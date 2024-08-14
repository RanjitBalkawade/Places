//
//  Factory.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//


import UIKit

class Factory {
        
    static func mainCoordinator() -> MainCoordinatorProtocol {
        MainCoordinator(navigationController: UINavigationController())
    }
    
    static func locationsGetService() -> LocationsGetServiceProtocol {
        LocationsGetService()
    }
}
