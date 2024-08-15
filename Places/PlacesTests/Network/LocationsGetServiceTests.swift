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
        self.sut = LocationsGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: self.urlString)
    }
    
    override func tearDown() {
        self.sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
        MockURLProtocol.response = nil
    }
    
    func testLocationsGetService_whenGivenSuccessfulResponse_ShouldReturnSuccess() async throws {
        //Arrange
        MockURLProtocol.stubResponseData = "{\"locations\":[{\"name\": \"Amsterdam\",\"lat\": 52.3547498,\"long\": 4.8339215}]}".data(using: .utf8)
        
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        //Act
        let locations = try await self.sut.getLocations()
        
        //Assert
        XCTAssertEqual(locations.count, 1, "should have return data")
        
    }
    
    func testLocationsGetService_WhenJsonDecodingFails_shouldReturnDecodingError() async {
        //Arrange
        MockURLProtocol.stubResponseData = "".data(using: .utf8)
        MockURLProtocol.response = HTTPURLResponse(
            url: URL(string: self.urlString)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        //Act
        do {
            _ = try await self.sut.getLocations()
            XCTFail("Expected to fail")
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.decoding)
        }
        
    }
    
    func testLocationsGetService_whenNetworkErrorOccurs_shouldReturnNetworkError() async {
        //Arrrange
        let sut = LocationsGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")
        
        //Act
        do {
            _ = try await sut.getLocations()
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.invalidURLRequest)
        }
    }
    
    func testArtCollectionservice_WhenInvalidUrlStringGiven_ShouldReturnInvalidUrlRequestError() async {
        //Arrrange
        let sut = LocationsGetService(session: MockURLProtocol.getSessionWithMockURLProtocol(), urlString: "")
        
        //Act
        do {
            _ = try await sut.getLocations()
        }
        catch {
            //Assert
            XCTAssertEqual(error as! DataResponseError, DataResponseError.invalidURLRequest)
        }
    }
    
}

