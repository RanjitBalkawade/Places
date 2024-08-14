//
//  MainCoordinatorProtocol.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit

protocol MainCoordinatorProtocol {
    
    // MARK: - Public properties
    
    var navigationController: UINavigationController { get set }
    
    // MARK: - Public methods
    
    func start()
}
