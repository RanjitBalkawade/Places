//
//  LocationsFixture.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import Foundation
@testable import Places

class LocationsFixture {
    
    static let location = Location(name: "Amsterdam", lat: 1.2333, long: 2.1233)
    
    static let locations = [
        Location(name: "Amsterdam", lat: 1.2333, long: 2.1233),
        Location(name: "Mumbai", lat: 2.2333, long: 3.1233)
    ]
}
