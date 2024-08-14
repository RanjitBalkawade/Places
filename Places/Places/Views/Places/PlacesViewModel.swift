//
//  PlacesViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

class PlacesViewModel: ObservableObject {
    
    enum ViewState {
        case successView
        case failureView
        case loading
    }
    
    @Published var viewState: ViewState = .loading
    
    var placeItemViewModels: [PlaceItemViewModel]? {
        locations?.filter {
            $0.name != nil
        }
        .map {
            PlaceItemViewModel(location: $0)
        }
    }
    
    private let service: LocationsGetServiceProtocol
    private var locations: [Location]?
    
    init(service: LocationsGetServiceProtocol) {
        self.service = service
    }
    
    //MARK: - Internal methods
    
    func loadData() async {
        
        await MainActor.run {
            viewState = .loading
        }
        
        do {
            self.locations = try await self.service.getLocations()
            
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
    
}
