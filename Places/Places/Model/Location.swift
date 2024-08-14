//
//  Locations.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

// MARK: - Location
struct Location: Codable {
    let name: String?
    let lat, long: Double
}
