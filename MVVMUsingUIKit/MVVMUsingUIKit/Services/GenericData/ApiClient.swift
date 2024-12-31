//
//  ApiClient.swift
//  VIM
//
//  Created by Suneel Apprikart on 19/09/24.
//

import Foundation

struct APIResponse<T: Decodable> {
    let data: T?
    let error: APIClientError?
    let statusCode: Int?
}

class APIClient {
    static func callAPI<T: Decodable> (
        url: String,
        method: HTTPMethod = .get,
        body: Data? = nil,
        headers: [String: String] = [:],
        token: String? = nil,
        identityToken: String? = nil
    ) async -> (APIResponse<T>) {
        // Ensure URL is valid
        guard let encodedURLString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedURL = URL(string: encodedURLString) else {
            return APIResponse(data: nil, error: .invalidURL, statusCode: nil)
        }
        
        // Log URL and body (for debugging, avoid logging sensitive data in production)
        LogFile.debugMessage(debug: "URL--->", value: url)
        if let body = body {
            let jsonString = String(data: body, encoding: .utf8)
            LogFile.debugMessage(debug: "Body Request", value: jsonString)
        }
        
        // Set up the URLRequest
        var request = URLRequest(url: encodedURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Include token in headers if available
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let identityTokenStr = identityToken {
            request.setValue(identityTokenStr, forHTTPHeaderField: "Authorization")
        }
        
        LogFile.debugMessage(debug: "URLRequest Headers --->", value: request.allHTTPHeaderFields)
        
        // Ensure request body is added only for non-GET methods
        if method != .get, let body = body {
            request.httpBody = body
        }
        
        do {
            // Make the network request
            let (data, response) = try await URLSession.shared.data(for: request)
            
            let otpStr = String(data: data, encoding: .utf8)
            LogFile.debugMessage(debug: "HTTP Response", value: otpStr)
            // Cast response to HTTPURLResponse to access status code
            guard let httpResponse = response as? HTTPURLResponse else {
                return APIResponse(data: nil, error: .invalidResponse, statusCode: nil)
            }
            
            let statusCode = httpResponse.statusCode
            LogFile.debugMessage(debug: "HTTP Response Status Code", value: statusCode)
            
            switch statusCode {
            case 200...299:  // Success
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return APIResponse(data: decodedData, error: nil, statusCode: statusCode)
                } catch let error {
                    LogFile.debugMessage(debug: "Decoding ErrorDecoding Error --->", value: error)
                    return APIResponse(data: nil, error: .decodingFailed, statusCode: statusCode)
                }
                
            case 401:
                return APIResponse(data: nil, error: .authenticationFailed, statusCode: statusCode)
                
            case 403:  // Authentication/Authorization error
                do {
                    let errorResponse = try JSONDecoder().decode(CustomErrorData.self, from: data)
                    let apiError = APIError(message: errorResponse.message ?? "Unauthorized", code: statusCode, errorData: errorResponse)
                    return APIResponse(data: nil, error: .apiError(apiError), statusCode: statusCode)
                } catch {
                    return APIResponse(data: nil, error: .authenticationFailed, statusCode: statusCode)
                }
                
            case 409:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return APIResponse(data: decodedData, error: nil, statusCode: statusCode)
                } catch let error {
                    LogFile.debugMessage(debug: "Decoding ErrorDecoding Error --->", value: error)
                    return APIResponse(data: nil, error: .decodingFailed, statusCode: statusCode)
                }
                
            default:  // Other status codes (e.g., 4xx, 5xx)
                do {
                    let errorResponse = try JSONDecoder().decode(CustomErrorData.self, from: data)
                    let apiError = APIError(message: errorResponse.message ?? "API Error", code: statusCode, errorData: errorResponse)
                    return APIResponse(data: nil, error: .apiError(apiError), statusCode: statusCode)
                } catch {
                    // Generic error if unable to decode error response
                    let apiError = APIError(message: "Unknown API Error", code: statusCode, errorData: nil)
                    return APIResponse(data: nil, error: .apiError(apiError), statusCode: statusCode)
                }
            }
            
        } catch {
            // Catching any network errors or other unexpected errors
            LogFile.debugMessage(debug: "Request Failed Error --->", value: error)
            return APIResponse(data: nil, error: .requestFailed(error), statusCode: nil)
        }
    }
}
