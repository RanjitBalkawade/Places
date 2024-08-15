//
//  GetService.swift
//  Places
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import Foundation

protocol GetServiceProtocol {
    associatedtype T: Codable
    
    var urlString: String { get set }
    var session: URLSession { get set }
    func execute(urlRequest: URLRequest) async throws -> T
}

extension GetServiceProtocol {
    func execute(urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: urlRequest)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.hasSuccessStatusCode else {
            throw DataResponseError.network
        }
        
        do {
            let modelData = try JSONDecoder().decode(T.self, from: data)
            return modelData
        }
        catch {
            throw DataResponseError.decoding
        }
    }
}

enum DataResponseError: Error {
    case network
    case decoding
    case noData
    case invalidURLRequest
}

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= self.statusCode
    }
}
