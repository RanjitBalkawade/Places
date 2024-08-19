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
                printError(code: httpResponse.statusCode, description: httpResponse.description)
                throw httpResponse.convertToDataError()
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
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
            printError(code: nsError.code, description: nsError.localizedDescription)
            throw nsError.converToDataError()
        }
    }
    
    //MARK: - Private methods
    
    private func printError(code: Int, description: String) {
        print("Request failed with error code: \(code) description: \(description)")
    }
}
