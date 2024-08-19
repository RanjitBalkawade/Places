//
//  PlaceItemViewModel.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

extension PlaceItemViewModel: Identifiable {
    var id: String {
        UUID().uuidString
    }
}

final class PlaceItemViewModel: ObservableObject {
    
    //MARK: - Internal properties
    
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
