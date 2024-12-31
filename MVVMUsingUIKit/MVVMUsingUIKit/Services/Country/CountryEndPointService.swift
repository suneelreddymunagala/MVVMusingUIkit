//
//  CountryEndPointService.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

struct CountryEndPointService {
    
    static func getAllCountries() async -> APIResponse<[CountryData]> {
        let url = CountryCodeEndPoint.allCountries.getFullPath()
        
        return await APIClient.callAPI(url: url, method: .get, body: nil, token: nil)
    }
}
