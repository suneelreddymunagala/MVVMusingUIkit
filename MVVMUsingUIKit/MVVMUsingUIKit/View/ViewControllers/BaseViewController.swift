//
//  BaseViewController.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoader(custom: String = "Loading...") {
        ProgressHudHelper.shared.showLoader(message: custom)
    }
    
    func hideLoader() {
        ProgressHudHelper.shared.hideLoader()
    }

}
