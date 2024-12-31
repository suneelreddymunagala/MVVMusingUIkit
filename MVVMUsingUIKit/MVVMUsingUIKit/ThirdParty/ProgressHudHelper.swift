//
//  ProgressHudHelper.swift
//  VIM
//
//  Created by Suneel Apprikart on 03/06/24.
//

import Foundation
import SVProgressHUD


struct ProgressHudHelper {
    static let shared = ProgressHudHelper()
        
    func showLoader(message: String) {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show(withStatus: message)
    }
    func hideLoader() {
        SVProgressHUD.dismiss()
        SVProgressHUD.dismiss()
    }
}
