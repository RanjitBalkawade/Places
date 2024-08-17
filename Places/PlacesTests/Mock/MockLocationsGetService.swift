//
//  MockLocationsGetService.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import Foundation
@testable import Places


class MockLocationsGetService: LocationsGetServiceProtocol {
    
    private(set) var getLocationsCount = 0
    var getLocationsHandler: (() -> [Places.Location])?
    var loading: (() -> Void)?
    var getLocationsShouldReturnError = false
    var dataError: DataError?
    
    func getLocations() async throws -> [Places.Location] {
        getLocationsCount += 1
        
        if getLocationsShouldReturnError, let dataError {
            throw dataError
        }
        
        loading?()
        
        guard let getLocationsHandler = getLocationsHandler else {
            fatalError()
        }
        
        return getLocationsHandler()
    }
}
