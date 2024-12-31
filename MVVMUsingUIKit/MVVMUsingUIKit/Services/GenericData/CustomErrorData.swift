//
//  CustomErrorData.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import Foundation

struct CustomErrorData: Decodable {
    let success: Bool?
    let message: String?
}

struct OndcErrorData: Decodable {
    let name: String?
    let message: String?
}


struct APIError: Error {
    let message: String
    let code: Int
    let errorData: CustomErrorData?
}

enum APIClientError: Error {
    case invalidURL
    case authenticationFailed
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed
    case apiError(APIError)
    case unknown
}
