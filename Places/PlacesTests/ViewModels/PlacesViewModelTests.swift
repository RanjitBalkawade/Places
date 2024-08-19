//
//  PlacesViewModelTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places

final class PlacesViewModelTests: XCTestCase {
    
    var sut: PlacesViewModel!
    var mockService: MockLocationsGetService!
    var mockCoordinator: MockMainCoordinator!
    
    override func setUp() {
        super.setUp()
        mockService = MockLocationsGetService()
        mockCoordinator = MockMainCoordinator()
        sut = PlacesViewModel(service: mockService, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testMainViewModel_WhenLoadingData_shouldReturnLoadingViewState() async {
        //Given
        mockService.getLocationsHandler = {
            //Then
            XCTAssertEqual(self.sut.viewState, .loading)
            return LocationsFixture.locations
        }
        //When
        await sut.loadData()
    }
    
    func testPlacesViewModel_WhenLoadDataSucceeds_shouldReturnSuccessViewState() async {
        // Given
        let expectedLocations = LocationsFixture.locations
        mockService.getLocationsHandler = { LocationsFixture.locations }
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .successView)
        XCTAssertEqual(sut.placeItemViewModels.count, expectedLocations.count)
        XCTAssertEqual(mockService.getLocationsCount, 1)
    }
    
    func testPlacesViewModel_WhenShowAddLocationTapped_shouldShowAddLocation() {
        // Given
        let newLocation = LocationsFixture.location
        
        mockCoordinator.showAddLocationHandler = { completion in
            completion(newLocation)
        }
        
        // When
        sut.showAddLocation()
        
        // Then
        XCTAssertEqual(sut.userDefinedPlaceItemViewModels.count, 1)
        XCTAssertEqual(sut.userDefinedPlaceItemViewModels.first?.latitude, newLocation.lat)
        XCTAssertEqual(mockCoordinator.showAddLocationCallCount, 1)
    }
    
    func testPlacesViewModel_WhenShowLocationTapped_ShouldShowLocation() {
        // Given
        let location = LocationsFixture.location
        let placeItemViewModel = PlaceItemViewModel(location: location)
        
        mockCoordinator.showLocationHandler = { _, _, _, completionHandler in
            completionHandler?(true)
        }
        
        // When
        sut.showLocation(placeItemViewModel)
        
        // Then
        XCTAssertEqual(mockCoordinator.showLocationCallCount, 1)
        XCTAssertEqual(mockCoordinator.showAlertCallCount, 0)
    }

    func testPlacesViewModel_WhenShowLocationFails_ShouldShowsAlert() {
        // Given
        let location = LocationsFixture.location
        let placeItemViewModel = PlaceItemViewModel(location: location)
        
        mockCoordinator.showLocationHandler = { _, _, _, completionHandler in
            completionHandler?(false)
        }
        
        // When
        sut.showLocation(placeItemViewModel)
        
        // Then
        XCTAssertEqual(mockCoordinator.showLocationCallCount, 1)
        XCTAssertEqual(mockCoordinator.showAlertCallCount, 1)
    }
    
    func testPlacesViewModel_LoadDataFailureWithServerError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .server
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .failureView)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(sut.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithClientError_ShouldShowFailureViewWithoutRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .client
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .failureView)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(sut.showRetryButton == false)
    }
    
    func testPlacesViewModel_LoadDataFailureWithGeneralError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .general
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .failureView)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(sut.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithNetworkConnectivityError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .internetConnectivity
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .failureView)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(sut.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithTimeoutError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .timeout
        
        // When
        await sut.loadData()
        
        // Then
        XCTAssertEqual(sut.viewState, .failureView)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(sut.showRetryButton)
    }
    
}
