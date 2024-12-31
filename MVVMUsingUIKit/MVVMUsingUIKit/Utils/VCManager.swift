//
//  VCManager.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import UIKit

struct VCManager {
    
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func navigateToCountryListVC() -> CountryListViewController? {
        return self.storyboard.instantiateViewController(withIdentifier: CountryListViewController.identifier) as? CountryListViewController
    }
}
