//
//  MockMainCoordinator.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import UIKit

final class MockMainCoordinator: MainCoordinatorProtocol {
    
    //MARK: - Internal properties
    
    var navigationController: UINavigationController = UINavigationController()
    
    //MARK: - Internal methods
    
    func start() {}
    func dismiss() {}
    func showAddLocation(completion: @escaping ((Location) -> Void)) {}
    func showLocation(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?) {}
    func showInstallLink(app: ExternalApp) {}
    
    func showAlert(
        title: String,
        message: String?,
        defaultHandler: ((UIAlertAction) -> Void)?,
        cancelHandler: ((UIAlertAction) -> Void)?
    ) {}
}
