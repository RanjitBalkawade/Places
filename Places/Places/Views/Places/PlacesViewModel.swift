//
//  PlacesViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation
import SwiftUI

final class PlacesViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case successView
        case failureView
    }
    
    //MARK: - Internal properties
    
    var alertTitle: String {
        "\(externalApp.name) is not installed on your device."
    }
    
    var alertMessage: String {
        "Please install \(externalApp.name) to view the location."
    }
    
    var locationsTitle: String {
        "Locations"
    }
    
    var locationsTitleAccessibilityHint: String {
        "Below is the list's section, which has app provided locations."
    }
    
    var userDefinedlocationsTitle: String {
        "User defined locations"
    }
    
    var userDefinedlocationsTitleAccessibilityHint: String {
        "Below is the list's section, which has locations defined by you."
    }
    
    var listAccessibilityHint: String {
        "This is the list of locations. You can tap on any location to view it on a map of \(externalApp.name) app."
    }
    
    var addLocationsTitle: String {
        "Add location"
    }
    
    var retryTitle: String {
        "Try again"
    }
    
    var loadingTitle: String {
        "Loading..."
    }
    
    var errorMessage: String {
        guard let dataError = dataError as? DataError else {
            return "Something has gone wrong with the app. Please install the latest version of the app if available or contact us."
        }
        
        return dataError.errorMessage
    }
    
    var errorMessageAccessibilityLabel: String {
        "Error message, \(errorMessage)"
    }
    
    var externalApp: ExternalApp {
        .wikipedia
    }
    
    var placeItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: locations)
    }
    
    var userDefinedPlaceItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: userDefinedLocations)
    }
    
    var showRetryButton: Bool {
        guard let dataError = dataError as? DataError else {
            return false
        }
        
        return dataError != .client && dataError != .decoding && dataError != .invalidURLRequest && dataError != .unknown
    }
    
    @Published private(set) var viewState: ViewState = .loading
    
    //MARK: - Private properties
    
    private var locations: [Location] = []
    private var userDefinedLocations: [Location] = []
    private var dataError: Error?
    private let service: LocationsGetServiceProtocol
    private let coordinator: MainCoordinatorProtocol
    
    //MARK: - Initializer
    
    init(service: LocationsGetServiceProtocol, coordinator: MainCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
    
    //MARK: - Actions
    
    func showAddLocation() {
        coordinator.showAddLocation() { [weak self] location in
            self?.userDefinedLocations.append(location)
        }
    }
    
    func showLocation(_ viewModel: PlaceItemViewModel) {
        
        coordinator.showLocation(
            app: externalApp,
            latitude: viewModel.latitude,
            longitude: viewModel.longitude
        ) { [weak self] isSuccess in
            
            guard isSuccess == false, let alertTitle = self?.alertTitle, let externalApp = self?.externalApp else {
                return
            }
            
            self?.coordinator.showAlert(
                title: alertTitle,
                message: self?.alertMessage,
                defaultHandler: { [weak self] _ in
                    self?.coordinator.showInstallLink(app: externalApp)
                },
                cancelHandler: nil
            )
        }
    }
    
    //MARK: - Internal methods
    
    func loadData() async {
        await MainActor.run {
            viewState = .loading
        }
        
        do {
            locations = try await service.getLocations()
            
            await MainActor.run {
                viewState = .successView
            }
        }
        catch {
            await MainActor.run {
                dataError = error
                viewState = .failureView
            }
        }
    }
    
    //MARK: - Private methods
    
    private func getPlaceItemViewModels(locations: [Location]) -> [PlaceItemViewModel] {
        locations.filter {
            $0.name != nil
        }
        .map {
            PlaceItemViewModel(location: $0)
        }
    }
}

private extension DataError {
    var errorMessage: String {
        switch self {
            case .server:
                return "There is a backend issue. Please try again after some time."
            case .client, .decoding, .invalidURLRequest, .unknown:
                return "Something has gone wrong with the app. Please install the latest version of the app if available or contact us."
            case .information, .rediret, .general:
                return "Please try again after some time."
            case .internetConnectivity:
                return "It appears that there is a issue with your internet connection. Please check your internet connection and try again."
            case .timeout:
                return "Request took long time to process, please try again."
        }
    }
}
