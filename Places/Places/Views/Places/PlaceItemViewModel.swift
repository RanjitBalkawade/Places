//
//  PlaceItemViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

final class PlaceItemViewModel: ObservableObject, Identifiable {
    
    //MARK: - Internal properties
    
    let id = UUID().uuidString
    
    var name: String {
        location.name ?? "Unknown location"
    }
    
    var latitude: Double {
        location.lat
    }
    
    var longitude: Double {
        location.long
    }
    
    //MARK: - Private properties
    
    private let location: Location
    
    //MARK: - Initializer
    
    init(location: Location) {
        self.location = location
    }
}
