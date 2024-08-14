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
    
    private let service: LocationsGetServiceProtocol
    
    init(service: LocationsGetServiceProtocol) {
        self.service = service
    }
    
}
