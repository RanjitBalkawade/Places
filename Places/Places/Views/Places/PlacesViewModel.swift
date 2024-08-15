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
        case successView
        case failureView
        case loading
    }
    
    @Published var viewState: ViewState = .loading

    var placeItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: locations)
    }
    
    var userDefinedPlaceItemViewModels: [PlaceItemViewModel] {
        getPlaceItemViewModels(locations: userDefinedLocations)
    }

    private let service: LocationsGetServiceProtocol
    private let coordinator: MainCoordinatorProtocol
    private var locations: [Location] = []
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
                viewState = .failureView
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
