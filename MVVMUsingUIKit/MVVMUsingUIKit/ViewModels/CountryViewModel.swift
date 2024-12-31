//
//  Untitled.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//
import Foundation

class CountryViewModel {

    private var countryData: CountryData
    
    
    var name: String {
        return countryData.name?.common ?? ""
    }
    
    init(countryData: CountryData) {
        self.countryData = countryData
    }
}
