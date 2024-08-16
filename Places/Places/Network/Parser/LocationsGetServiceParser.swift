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
    
    var locations: [Location] {
        response.locations
    }
    
    private let response: LocationsGetResponse
    
    init(_ response: LocationsGetResponse) {
        self.response = response
    }
}
