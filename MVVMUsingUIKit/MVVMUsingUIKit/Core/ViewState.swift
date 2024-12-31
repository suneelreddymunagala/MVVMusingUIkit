//
//  ViewState.swift
//  MVVMUsingUIKit
//
//  Created by Suneel Apprikart on 31/12/24.
//

import Foundation

enum ViewState {
    case loading
    case success
    case error(APIClientError?)
    case idle
}
