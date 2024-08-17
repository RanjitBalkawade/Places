//
//  AddLocationViewSnapshotTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 17/08/2024.
//

import XCTest
import SwiftUI
import SnapshotTesting

@testable import Places

class AddLocationViewSnapshotTests: XCTestCase {
    func testMainView_InitialState() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    func testMainView_EmptyNameError() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewModel.addLocation(name: "", latitude: "52.379189", longitude: "4.899431")
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    func testMainView_EmptyLatitude() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewModel.addLocation(name: "Amsterdam", latitude: "", longitude: "4.899431")
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    func testMainView_EmptyLongitude() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewModel.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "")
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    func testMainView_InvalidLatitude() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewModel.addLocation(name: "Amsterdam", latitude: "invalid_lat", longitude: "4.899431")
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
    func testMainView_InvalidLongitude() {
        let mockCoordinator = MockMainCoordinator()
        
        let viewModel = AddLocationViewModel(coordinator: mockCoordinator) { _ in }
        let view = AddLocationView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        viewModel.addLocation(name: "Amsterdam", latitude: "52.379189", longitude: "invalid_lon")
        
        assertSnapshot(of: viewController, as: .image(on: .iPhone13), record: false)
    }
    
}

