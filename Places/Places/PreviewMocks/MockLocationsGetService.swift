//
//  MockLocationsGetService.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

class MockLocationsGetService: LocationsGetServiceProtocol {
    
    func getLocations() async throws -> [Location] {
        let location1 = Location(name: "Amsterdam", lat: 1.2333, long: 2.1233)
        let location2 = Location(name: "Mumbai", lat: 2.2333, long: 3.1233)
        return [location1, location2]
    }
    
}
