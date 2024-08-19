//
//  LocationsGetServiceTests.swift
//  PlacesTests
//
//  Created by Ranjeet Balkawade on 15/08/2024.
//

import XCTest
@testable import Places

class LocationsGetServiceTests: XCTestCase {
    
    var sut: LocationsGetService!
    let urlString = "https://www.haha.com"
    
    override func setUp() {
        sut = LocationsGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: urlString)
    }
    
    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        MockURLProtocol.response = nil
    }
    
    func testLocationsGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        // Given
        MockURLProtocol.stubResponseData = "{\"locations\":[{\"name\": \"Amsterdam\",\"lat\": 52.3547498,\"long\": 4.8339215}]}".data(using: .utf8)
        
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        // When
        let locations = try await sut.getLocations()
        
        // Then
        XCTAssertEqual(locations.count, 1, "should have return data")
        
    }
    
    func testLocationsGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
        // Given
        MockURLProtocol.stubResponseData = "{invalid json}".data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.decoding)
        }
        
    }
    
    func testLocationsGetService_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        // Given
        let sut = LocationsGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")
        
        // When
        do {
            _ = try await sut.getLocations()
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.invalidURLRequest)
        }
    }
    
    func testLocationsGetService_WhenServerSideErrorOccurs_ShouldReturnServerDataError() async throws {
        // Given
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.server)
        }
    }
    
    func testLocationsGetService_WhenClientSideErrorOccurs_ShouldReturnClientDataError() async {
        // Given
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.client)
        }
    }
    
    func testLocationsGetService_WhenRedirectionalTypeErrorOccurs_ShouldReturnRedirectionDataError() async {
        // Given
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 302,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.rediret)
        }
    }
    
    func testLocationsGetService_WhenInformationTypeErrorOccurs_ShouldReturnInformationDataError() async {
        // Given
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: urlString)!,
            statusCode: 100,
            httpVersion: nil,
            headerFields: nil
        )
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.information)
        }
    }
    
    func testLocationsGetService_WhenIssueWithInternetConnectivity_ShouldReturnInternetConnectivityDataError() async {
        // Given
        MockURLProtocol.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.internetConnectivity)
        }
    }
    
    func testLocationsGetService_WhenRequestTimeout_ShouldReturnTimeoutDataError() async {
        // Given
        MockURLProtocol.error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.timeout)
        }
    }
    
    func testLocationsGetService_WhenGeneralErrorWithRequest_ShouldReturnGeneralDataError() async {
        // Given
        MockURLProtocol.error = NSError(domain: NSURLErrorDomain, code: -999, userInfo: nil)
        
        // When
        do {
            _ = try await sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            // Then
            XCTAssertEqual(error as! DataError, DataError.general)
        }
    }
    
}

