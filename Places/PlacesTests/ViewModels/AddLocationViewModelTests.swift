//
//  AddLocationViewModelTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places

class AddLocationViewModelTests: XCTestCase {
    
    var viewModel: AddLocationViewModel!
    var mockCoordinator: MockMainCoordinator!
    var completionLocation: Location?
    
    override func setUp() {
        super.setUp()
        mockCoordinator = MockMainCoordinator()
        viewModel = AddLocationViewModel(coordinator: mockCoordinator) { location in
            self.completionLocation = location
        }
    }
    
    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        completionLocation = nil
        super.tearDown()
    }
    
    // MARK: - Computed Properties Tests
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Add location")
    }
    
    func testMessage() {
        XCTAssertEqual(viewModel.message, "Please add details below to add new location.")
    }
    
    func testNamePlaceHolder() {
        XCTAssertEqual(viewModel.namePlaceHolder, "Name")
    }
    
    func testLatitudePlaceHolder() {
        XCTAssertEqual(viewModel.latitudePlaceHolder, "Latitude")
    }
    
    func testLongitudePlaceHolder() {
        XCTAssertEqual(viewModel.longitudePlaceHolder, "Longitude")
    }
    
    func testAddButtonTitle() {
        XCTAssertEqual(viewModel.addButtonTitle, "Add")
    }
    
    func testAddLocationWithEmptyName() {
        viewModel.addLocation(name: "", latitude: "52.379189", longitude: "4.899431")
        XCTAssertEqual(viewModel.addLocationError, .NameNotAdded)
    }
    
    func testAddLocationWithEmptyLatitude() {
        viewModel.addLocation(name: "Amsterdam", latitude: "", longitude: "4.899431")
        XCTAssertEqual(viewModel.addLocationError, .LatitudeNotAdded)
    }
    
    func testAddLocationWithEmptyLongitude() {
        viewModel.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "")
        XCTAssertEqual(viewModel.addLocationError, .LongitudeNotAdded)
    }
    
    func testAddLocationWithInvalidLatitude() {
        viewModel.addLocation(name: "Amsterdam", latitude: "invalid_lat", longitude: "4.899431")
        XCTAssertEqual(viewModel.addLocationError, .wrongLatitude)
    }
    
    func testAddLocationWithInvalidLongitude() {
        viewModel.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "invalid_lon")
        XCTAssertEqual(viewModel.addLocationError, .wrongLongitude)
    }
    
    func testAddLocationWithValidData() {
        
        let location = LocationsFixture.location
        
        viewModel.addLocation(name: location.name ?? "Amsterdam", latitude: String(location.lat), longitude: String(location.long))
        
        XCTAssertNil(viewModel.addLocationError)
        XCTAssertNotNil(completionLocation)
        XCTAssertEqual(completionLocation?.name, location.name)
        XCTAssertEqual(completionLocation?.lat, location.lat)
        XCTAssertEqual(completionLocation?.long, location.long)
        XCTAssertEqual(mockCoordinator.dismissCallCount, 1)
    }
}
