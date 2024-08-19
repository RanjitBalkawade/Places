//
//  MockNavigationController.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import UIKit

final class MockNavigationController: UINavigationController {
    
    //MARK: - Internal properties
    
    var pushViewControllerCalled = false
    var pushedViewController: UIViewController?
    
    var popViewControllerCalled = false
    
    var presentCalled = false
    var presentedVC: UIViewController?
    
    //MARK: - Life cycle methods
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushedViewController = viewController
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerCalled = true
        return super.popViewController(animated: animated)
    }
    
    override func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        presentedVC = viewController
    }
}
