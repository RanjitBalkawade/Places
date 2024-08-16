//
//  LocationsGetServiceParserTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 16/08/2024.
//

import XCTest
@testable import Places

final class LocationsGetServiceParserTests: XCTestCase {
    
    func testLocationsGetServiceParser_shouldReturnLocations() {
        // Given
        let response = LocationsGetResponse(locations: LocationsFixture.locations)
        
        // When
        let parser = LocationsGetServiceParser(response)
        
        // Then
        XCTAssertEqual(parser.locations.count, 2)
        XCTAssertEqual(parser.locations[0].name, LocationsFixture.locations[0].name)
        XCTAssertEqual(parser.locations[0].lat, LocationsFixture.locations[0].lat)
        XCTAssertEqual(parser.locations[1].name, LocationsFixture.locations[1].name)
        XCTAssertEqual(parser.locations[1].lat, LocationsFixture.locations[1].lat)
    }
}
