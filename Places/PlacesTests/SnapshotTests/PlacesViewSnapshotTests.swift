//
//  PlacesViewSnapshotTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//


import XCTest
import SwiftUI
import SnapshotTesting

@testable import Places

class PlacesViewSnapshotTests: XCTestCase {
    func testPlacesView_SuccessState() {
        let mockService = MockLocationsGetService()
        let mockCoordinator = MockMainCoordinator()
        
        mockService.getLocationsHandler = {
            LocationsFixture.locations
        }
        let viewModel = PlacesViewModel(service: mockService, coordinator: mockCoordinator)
        let view = PlacesView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        let expectation = XCTestExpectation(description: "Async task")
        Task {
            await viewModel.loadData()
            await MainActor.run {
                assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testPlacesView_FailureState() {
        let mockService = MockLocationsGetService()
        let mockCoordinator = MockMainCoordinator()
        
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .general

        let viewModel = PlacesViewModel(service: mockService, coordinator: mockCoordinator)
        let view = PlacesView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        let expectation = XCTestExpectation(description: "Async task")
        Task {
            await viewModel.loadData()
            await MainActor.run {
                assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testPlacesView_LoadingState() {
        let mockService = MockLocationsGetService()
        let mockCoordinator = MockMainCoordinator()
        
        mockService.getLocationsShouldReturnError = true
        mockService.dataError = .general
        
        let viewModel = PlacesViewModel(service: mockService, coordinator: mockCoordinator)
        let view = PlacesView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
}
