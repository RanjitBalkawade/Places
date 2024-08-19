//
//  MockURLProtocol.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    //MARK: - Internal properties
    
    static var stubResponseData: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    
    //MARK: - Life cycle methods
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let response = MockURLProtocol.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}

extension MockURLProtocol {
    static func getSessionWithMockURLProtocol() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
}
