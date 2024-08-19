//
//  MockMainCoordinator.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import UIKit

@testable
import Places

final class MockMainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController = UINavigationController()
    
    private(set) var startCallCount = 0
    var startHandler: (() -> Void)?
    func start() {
        startCallCount += 1
        if let startHandler = startHandler {
            startHandler()
        }
    }
    
    private(set) var dismissCallCount = 0
    var dismissHandler: (() -> Void)?
    func dismiss() {
        dismissCallCount += 1
        dismissHandler?()
    }
    
    private(set) var showAddLocationCallCount = 0
    var showAddLocationHandler: ((@escaping (Location) -> Void) -> Void)?
    func showAddLocation(completion: @escaping ((Location) -> Void)) {
        showAddLocationCallCount += 1
        showAddLocationHandler?(completion)
    }
    
    private(set) var showLocationCallCount = 0
    var showLocationHandler: ((ExternalApp, Double, Double, ((Bool) -> Void)?) -> Void)?
    func showLocation(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?) {
        showLocationCallCount += 1
        showLocationHandler?(app, latitude, longitude, completionHandler)
    }
    
    private(set) var showInstallLinkCallCount = 0
    var showInstallLinkHandler: ((ExternalApp) -> Void)?
    func showInstallLink(app: ExternalApp) {
        showInstallLinkCallCount += 1
        showInstallLinkHandler?(app)
    }

    private(set) var showAlertCallCount = 0
    var showAlertHandler: ((String, String?, ((UIAlertAction) -> Void)?, ((UIAlertAction) -> Void)?) -> Void)?
    func showAlert(title: String, message: String?, defaultHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?) {
        showAlertCallCount += 1
        showAlertHandler?(title, message, defaultHandler, cancelHandler)
    }
    
}
