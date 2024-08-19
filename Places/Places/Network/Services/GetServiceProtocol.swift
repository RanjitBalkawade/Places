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
    
    //MARK: - Internal methods
    
    func execute(urlRequest: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw DataError.unknown
            }
            
            guard httpResponse.hasSuccessStatusCode else {
                print("Request failed with error code: \(httpResponse.statusCode) description: \(httpResponse.description)")
                throw httpResponse.convertToDataError()
            }
            
            do {
                let modelData = try JSONDecoder().decode(T.self, from: data)
                return modelData
            }
            catch {
                throw DataError.decoding
            }
            
        }
        catch let dataError as DataError {
            throw dataError
        }
        catch {
            guard let nsError = error as NSError? else {
                throw DataError.unknown
            }
            print("Request failed with error code: \(nsError.code) description: \(nsError.localizedDescription)")
            throw nsError.converToDataError()
        }
    }
}
