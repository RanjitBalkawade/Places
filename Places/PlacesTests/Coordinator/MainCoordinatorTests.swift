//
//  MainCoordinatorTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places

class MainCoordinatorTests: XCTestCase {
    
    var sut: MainCoordinator!
    var mockNavigationController: MockNavigationController!
    var mockExternalAppCommunicator: MockExternalAppCommunicator!
    var mockLocationsGetService: MockLocationsGetService!
    
    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        mockExternalAppCommunicator = MockExternalAppCommunicator()
        mockLocationsGetService = MockLocationsGetService()
        sut = MainCoordinator(
            navigationController: mockNavigationController,
            locationsGetService: mockLocationsGetService,
            externalAppCommunicator: mockExternalAppCommunicator
        )
    }
    
    override func tearDown() {
        sut = nil
        mockNavigationController = nil
        mockExternalAppCommunicator = nil
        mockLocationsGetService = nil
        super.tearDown()
    }
    
    func testMainCoordinator_StartPushesPlacesViewController() {
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(mockNavigationController.pushViewControllerCalled)
        XCTAssertTrue(mockNavigationController.pushedViewController is PlacesViewController)
    }
    
    func testMainCoordinator_ShowAddLocationPushesAddLocationViewController() {
        // Given
        let completion: ((Location) -> Void) = { _ in }
        
        // When
        sut.showAddLocation(completion: completion)
        
        // Then
        XCTAssertTrue(mockNavigationController.pushViewControllerCalled)
        XCTAssertTrue(mockNavigationController.pushedViewController is AddLocationViewController)
    }
    
    func testMainCoordinator_DismissPopsViewController() {
        // When
        sut.dismiss()
        
        // Then
        XCTAssertTrue(mockNavigationController.popViewControllerCalled)
    }
    
    func testMainCoordinator_ShowInstallLinkCallsExternalAppCommunicator() {
        // Given
        let app = ExternalApp.wikipedia
        
        // When
        sut.showInstallLink(app: app)
        
        // Then
        XCTAssertTrue(mockExternalAppCommunicator.showInstallLinkCalled)
        XCTAssertEqual(mockExternalAppCommunicator.passedApp, app)
    }
    
    func testMainCoordinator_ShowLocationCallsExternalAppCommunicatorWithCorrectParameters() {
        // Given
        let app = ExternalApp.wikipedia
        let latitude = 37.7749
        let longitude = -122.4194
        let completionHandler: ((Bool) -> Void)? = { _ in }
        
        // When
        sut.showLocation(app: app, latitude: latitude, longitude: longitude, completionHandler: completionHandler)
        
        // Then
        XCTAssertTrue(mockExternalAppCommunicator.openPlacesCalled)
        XCTAssertEqual(mockExternalAppCommunicator.passedApp, app)
        XCTAssertEqual(mockExternalAppCommunicator.passedLatitude, latitude)
        XCTAssertEqual(mockExternalAppCommunicator.passedLongitude, longitude)
        XCTAssertNotNil(mockExternalAppCommunicator.passedCompletionHandler)
    }
    
    func testMainCoordinator_ShowAlertPresentsAlertController() {
        // Given
        let title = "Test Title"
        let message = "Test Message"
        
        // When
        sut.showAlert(title: title, message: message)
        
        // Then
        XCTAssertTrue(mockNavigationController.presentCalled)
        XCTAssertTrue(mockNavigationController.presentedVC is UIAlertController)
        let alertController = mockNavigationController.presentedVC as! UIAlertController
        XCTAssertEqual(alertController.title, title)
        XCTAssertEqual(alertController.message, message)
        XCTAssertEqual(alertController.actions.count, 2)
    }
}
