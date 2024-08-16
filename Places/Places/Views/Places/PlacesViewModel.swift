//
//  PlacesViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation
import SwiftUI

class PlacesViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case successView
        case failureViewWithRetry
        case failureView
    }
    
    @Published var viewState: ViewState = .loading

    var placeItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: locations)
    }
    
    var userDefinedPlaceItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: userDefinedLocations)
    }
    
    var errorMessage: String {
        switch dataError {
            case .server:
                "There is a backend issue. Please try again after some time."
            case .client, .decoding, .invalidURLRequest, .unknown, nil:
                "Something has gone wrong with the app. Please install the latest version of the app if available or contact us."
            case .information, .rediret, .general:
                "Please try again after some time."
            case .internetConnectivity:
                "It appears that there is a issue with your internet connection. Please check your internet connection and try again."
            case .timeout:
                "Request took long time to process, please try again."
        }
    }

    private let service: LocationsGetServiceProtocol
    private let coordinator: MainCoordinatorProtocol
    private var locations: [Location] = []
    private var dataError: DataError?
    
    @Published private var userDefinedLocations: [Location] = []
    
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
                guard let error = error as? DataError else {
                    viewState = .failureView
                    return
                }
                dataError = error
                
                if error == .client || error == .decoding || error == .invalidURLRequest || error == .unknown {
                    viewState = .failureView
                } else {
                    viewState = .failureViewWithRetry
                }
            }
        }
    }
    
    private func getPlaceItemViewModels(locations: [Location]) -> [PlaceItemViewModel] {
        locations.filter {
            $0.name != nil
        }
        .map {
            PlaceItemViewModel(location: $0)
        }
    }
}
