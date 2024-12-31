//
//  CountryEndPoint.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import Foundation

enum CountryCodeEndPoint {
    case allCountries
    
    var path: String {
        switch self {
        case .allCountries: return "all"
        }
    }
    
    
    func getFullPath() -> String {
        return AppConstants.BASE_URL + path
    }
    
}
