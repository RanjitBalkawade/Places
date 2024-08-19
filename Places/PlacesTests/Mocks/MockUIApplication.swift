//
//  MockUIApplication.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import UIKit
@testable import Places

final class MockUIApplication: UIApplicationOpenAppProtocol {
    
    //MARK: - Internal properties
    
    var openURLCalled = false
    var openURL: URL?
    
    //MARK: - Internal methods
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)? = nil) {
        openURLCalled = true
        openURL = url
    }
}

