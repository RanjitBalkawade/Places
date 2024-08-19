//
//  Factory.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//


import UIKit

final class Factory {
    
    //MARK: - Internal methods
    
    static func mainCoordinator() -> MainCoordinatorProtocol {
        MainCoordinator(navigationController: UINavigationController(), externalAppCommunicator: Self.externalAppCommunicator())
    }
    
    static func locationsGetService() -> LocationsGetServiceProtocol {
        LocationsGetService(session: URLSession.shared, urlString: Configuration.API.baseUrl)
    }
    
    static func externalAppCommunicator() -> ExternalAppCommunicator {
        ExternalAppCommunicator()
    }
}
