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

class PlaceItemViewModel: ObservableObject {
    
    var name: String {
        location.name ?? "Unknown location"
    }
    
    private let location: Location
    
    init(location: Location) {
        self.location = location
    }
}
