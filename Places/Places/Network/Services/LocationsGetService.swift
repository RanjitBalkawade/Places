//
//  LocationsGetService.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import Foundation

protocol LocationsGetServiceProtocol {
    func getLocations() async throws -> [Location]
}

extension LocationsGetService: LocationsGetServiceProtocol {}

final class LocationsGetService: GetServiceProtocol {
    
    typealias T = LocationsGetResponse
    
    var session: URLSession
    var urlString: String
    
    init(session: URLSession, urlString: String) {
        self.session = session
        self.urlString = urlString
    }
    
    func getLocations() async throws -> [Location] {
        guard let urlRequest = getURLRequest() else {
            throw DataError.invalidURLRequest
        }
        
        let response = try await execute(urlRequest: urlRequest)
        let parser = LocationsGetServiceParser(response)
        return parser.locations
    }
    
    private func getURLRequest() -> URLRequest? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
