//
//  AddLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places

class AddLocationViewModelTests: XCTestCase {
    
    var sut: AddLocationViewModel!
    var mockCoordinator: MockMainCoordinator!
    var completionLocation: Location?
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockMainCoordinator()
        sut = AddLocationViewModel(coordinator: mockCoordinator) { [weak self] location in
            self?.completionLocation = location
        }
    }
    
    override func tearDown() {
        sut = nil
        mockCoordinator = nil
        completionLocation = nil
        super.tearDown()
    }
    
    // MARK: - Computed Properties Tests
    
    func testAddLocationViewModel_Title() {
        XCTAssertEqual(sut.title, "Please add details below to add new location.")
    }
    
    func testAddLocationViewModel_NamePlaceHolder() {
        XCTAssertEqual(sut.namePlaceHolder, "Name")
    }
    
    func testAddLocationViewModel_LatitudePlaceHolder() {
        XCTAssertEqual(sut.latitudePlaceHolder, "Latitude")
    }
    
    func testAddLocationViewModel_LongitudePlaceHolder() {
        XCTAssertEqual(sut.longitudePlaceHolder, "Longitude")
    }
    
    func testAddLocationViewModel_AddButtonTitle() {
        XCTAssertEqual(sut.addButtonTitle, "Add")
    }
    
    func testAddLocationViewModel_AddLocationWithEmptyName() {
        sut.addLocation(name: "", latitude: "52.379189", longitude: "4.899431")
        XCTAssertEqual(sut.addLocationError, .NameNotAdded)
    }
    
    func testAddLocationViewModel_AddLocationWithEmptyLatitude() {
        sut.addLocation(name: "Amsterdam", latitude: "", longitude: "4.899431")
        XCTAssertEqual(sut.addLocationError, .LatitudeNotAdded)
    }
    
    func testAddLocationViewModel_AddLocationWithEmptyLongitude() {
        sut.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "")
        XCTAssertEqual(sut.addLocationError, .LongitudeNotAdded)
    }
    
    func testAddLocationViewModel_AddLocationWithInvalidLatitude() {
        sut.addLocation(name: "Amsterdam", latitude: "invalid_lat", longitude: "4.899431")
        XCTAssertEqual(sut.addLocationError, .wrongLatitude)
    }
    
    func testAddLocationViewModel_AddLocationWithInvalidLongitude() {
        sut.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "invalid_lon")
        XCTAssertEqual(sut.addLocationError, .wrongLongitude)
    }
    
    func testAddLocationViewModel_AddLocationWithValidData() {
        
        let location = LocationsFixture.location
        
        sut.addLocation(name: location.name ?? "Amsterdam", latitude: String(location.lat), longitude: String(location.long))
        
        XCTAssertNil(sut.addLocationError)
        XCTAssertNotNil(completionLocation)
        XCTAssertEqual(completionLocation?.name, location.name)
        XCTAssertEqual(completionLocation?.lat, location.lat)
        XCTAssertEqual(completionLocation?.long, location.long)
        XCTAssertEqual(mockCoordinator.dismissCallCount, 1)
    }
}
