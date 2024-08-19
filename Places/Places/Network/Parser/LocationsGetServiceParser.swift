//
//  LocationsGetServiceParser.swift
//  Places
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import Foundation

protocol LocationsGetServiceParserProtocol {
    var locations: [Location] { get }
}

final class LocationsGetServiceParser {
    
    //MARK: - Internal properties
    
    var locations: [Location] {
        response.locations
    }
    
    //MARK: - Private properties
    
    private let response: LocationsGetResponse
    
    //MARK: - Initializer
    
    init(_ response: LocationsGetResponse) {
        self.response = response
    }
}
