//
//  CountryData.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import Foundation

struct CountryData: Codable {
    var name: NameData?
}

// MARK: - Name
struct NameData: Codable {
    var common, official: String?
}
