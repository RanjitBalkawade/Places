//
//  MainCoordinator.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit

class MainCoordinator: MainCoordinatorProtocol {
    
    // MARK: - Public properties
    
    var navigationController: UINavigationController
    
    private let externalAppCommunicator: ExternalAppCommunicatorProtocol
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, externalAppCommunicator: ExternalAppCommunicatorProtocol) {
        self.navigationController = navigationController
        self.externalAppCommunicator = externalAppCommunicator
    }
    
    // MARK: - Public methods
    
    func start() {
        let viewModel = PlacesViewModel(service: Factory.locationsGetService(), coordinator: self)
        navigationController.pushViewController(PlacesViewController(viewModel), animated: false)
    }
    
    func showAddLocation(completion: @escaping ((Location) -> Void)) {
        let viewModel = AddLocationViewModel(coordinator: self, completion: completion)
        navigationController.pushViewController(AddLocationViewController(viewModel), animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
    func showInstallLink(app: ExternalApp) {
        externalAppCommunicator.showInstallLink(app: app)
    }
    
    func showLocation(app: ExternalApp, latitude: Double, longitude: Double, completionHandler: ((Bool) -> Void)?) {
        externalAppCommunicator.openPlaces(app: app, latitude: latitude, longitude: longitude, completionHandler: completionHandler)
    }
    
    func showAlert(
        title: String,
        message: String? = nil,
        defaultHandler: ((UIAlertAction) -> Void)? = nil,
        cancelHandler: ((UIAlertAction) -> Void)? = nil
    )
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: defaultHandler)
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler)
        alertController.addAction(cancelAction)

        self.navigationController.present(alertController, animated: true, completion: nil)
    }
}
