//
//  MockMainCoordinator.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import UIKit

class MockMainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {}
    func dismiss() {}
    func showAddLocation(completion: @escaping ((Location) -> Void)) {}
}
