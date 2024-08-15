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
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
}
