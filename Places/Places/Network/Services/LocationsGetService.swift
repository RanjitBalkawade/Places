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

class LocationsGetService: GetServiceProtocol {
    
    typealias T = LocationsGetResponse
    
    var session: URLSession
    var urlString: String
    
    init(session: URLSession, urlString: String) {
        self.session = session
        self.urlString = urlString
    }
    
    func getLocations() async throws -> [Location] {
        guard let urlRequest = self.getURLRequest() else {
            throw DataResponseError.invalidURLRequest
        }
        
        let response = try await self.execute(urlRequest: urlRequest)
        return response.locations
    }
    
    private func getURLRequest() -> URLRequest? {
        guard let url = URL(string: self.urlString) else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}
