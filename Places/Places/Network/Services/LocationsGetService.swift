//
//  LocationsGetService.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

protocol LocationsGetServiceProtocol {
    func getLocations() async throws -> [Location]
}

extension LocationsGetService: LocationsGetServiceProtocol {}

class LocationsGetService {
    
    func getLocations() async throws -> [Location] {
        fatalError()
    }
}
