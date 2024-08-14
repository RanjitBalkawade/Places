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
        navigationController.pushViewController(PlacesViewController(), animated: false)
    }
    
}
