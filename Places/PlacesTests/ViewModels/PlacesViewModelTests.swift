//
//  PlacesViewModelTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
@testable import Places

final class PlacesViewModelTests: XCTestCase {
    
    var viewModel: PlacesViewModel!
    var mockService: MockLocationsGetService!
    var mockCoordinator: MockMainCoordinator!
    
    override func setUp() {
        super.setUp()
        mockService = MockLocationsGetService()
        mockCoordinator = MockMainCoordinator()
        viewModel = PlacesViewModel(service: mockService, coordinator: mockCoordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockCoordinator = nil
        super.tearDown()
    }
    
    func testMainViewModel_WhenLoadingData_shouldReturnLoadingViewState() async {
        //Given
        self.mockService.getLocationsHandler = {
            //Then
            XCTAssertEqual(self.viewModel.viewState, .loading)
            return LocationsFixture.locations
        }
        //When
        await viewModel.loadData()
    }
    
    func testPlacesViewModel_WhenLoadDataSucceeds_shouldReturnSuccessViewState() async {
        // Given
        let expectedLocations = LocationsFixture.locations
        mockService.getLocationsHandler = { LocationsFixture.locations }
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .successView)
        XCTAssertEqual(viewModel.placeItemViewModels.count, expectedLocations.count)
        XCTAssertEqual(mockService.getLocationsCount, 1)
    }
    
    func testPlacesViewModel_WhenShowAddLocationTapped_shouldShowAddLocation() {
        // Given
        let newLocation = LocationsFixture.location
        
        mockCoordinator.showAddLocationHandler = { completion in
            completion(newLocation)
        }
        
        // When
        viewModel.showAddLocation()
        
        // Then
        XCTAssertEqual(viewModel.userDefinedPlaceItemViewModels.count, 1)
        XCTAssertEqual(viewModel.userDefinedPlaceItemViewModels.first?.latitude, newLocation.lat)
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
        viewModel.showLocation(placeItemViewModel)
        
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
        viewModel.showLocation(placeItemViewModel)
        
        // Then
        XCTAssertEqual(mockCoordinator.showLocationCallCount, 1)
        XCTAssertEqual(mockCoordinator.showAlertCallCount, 1)
    }
    
    func testPlacesViewModel_LoadDataFailureWithServerError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .server
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failureView)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(viewModel.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithClientError_ShouldShowFailureViewWithoutRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .client
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failureView)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(viewModel.showRetryButton == false)
    }
    
    func testPlacesViewModel_LoadDataFailureWithGeneralError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .general
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failureView)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(viewModel.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithNetworkConnectivityError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .internetConnectivity
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failureView)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(viewModel.showRetryButton)
    }
    
    func testPlacesViewModel_LoadDataFailureWithTimeoutError_ShouldShowFailureViewWithRetryButton() async {
        // Given
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .timeout
        
        // When
        await viewModel.loadData()
        
        // Then
        XCTAssertEqual(viewModel.viewState, .failureView)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(mockService.getLocationsCount, 1)
        XCTAssertTrue(viewModel.showRetryButton)
    }
    
}
