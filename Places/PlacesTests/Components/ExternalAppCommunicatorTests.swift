//
//  ExternalAppCommunicatorTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places


class ExternalAppCommunicatorTests: XCTestCase {
    
    var sut: ExternalAppCommunicator!
    var mockApplication: MockUIApplication!
    
    override func setUp() {
        super.setUp()
        mockApplication = MockUIApplication()
        sut = ExternalAppCommunicator(application: mockApplication)
    }
    
    override func tearDown() {
        sut = nil
        mockApplication = nil
        super.tearDown()
    }
    
    func testExternalAppCommunicator_WhenOpenPlacesCalled_ShouldSuccessfullyGenerateURL() {
        // Given
        let app = ExternalApp.wikipedia
        let latitude = 52.379189
        let longitude = 4.899431
        
        let expectedURLString = "wikipedia://places?lat=\(latitude)&lon=\(longitude)"
        let expectedURL = URL(string: expectedURLString)!
        
        // When
        sut.openPlaces(app: app, latitude: latitude, longitude: longitude) { _ in }
        
        // Then
        XCTAssertEqual(mockApplication.openURL, expectedURL)
        XCTAssertTrue(mockApplication.openURLCalled)
    }
    
    
    func testExternalAppCommunicator_WhenInstallLinkCalled_ShouldSuccessfullyGenerateURL() {
        // Given
        let app = ExternalApp.wikipedia
        let expectedURL = URL(string: app.installLink)!
        
        // When
        sut.showInstallLink(app: app)
        
        // Then
        XCTAssertEqual(mockApplication.openURL, expectedURL)
        XCTAssertTrue(mockApplication.openURLCalled)
    }
    
}

