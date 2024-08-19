//
//  MockLocationsGetService.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import Foundation
@testable import Places

final class MockLocationsGetService: LocationsGetServiceProtocol {
    
    //MARK: - Internal properties
    
    var getLocationsHandler: (() -> [Places.Location])?
    var loading: (() -> Void)?
    var getLocationsShouldReturnError = false
    var dataError: DataError?
    private(set) var getLocationsCount = 0
    
    //MARK: - Internal methods
    
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
