//
//  MapAPITests.swift
//  WaveCastTests
//
//  Created by Gonzalo Trujillo Vallejo on 26/5/24.
//

import XCTest
import CoreLocation
@testable import WaveCast

class MapAPITests: XCTestCase {
    
    func testGetLocation_Success() {
        let jsonString = """
        {
            "data": [
                {
                    "latitude": 37.7749,
                    "longitude": -122.4194,
                    "name": "San Francisco"
                }
            ]
        }
        """
        let data = jsonString.data(using: .utf8)
        let mockSession = MockURLSession(data: data, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        var result: Result<(CLLocationCoordinate2D, String), Error>?
        
        networkManager.getLocation(address: "San Francisco") { res in
            result = res
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        switch result {
        case .success(let (coordinate, name)):
            XCTAssertEqual(coordinate.latitude, 37.7749)
            XCTAssertEqual(coordinate.longitude, -122.4194)
            XCTAssertEqual(name, "San Francisco")
        default:
            XCTFail("Expected success, got \(String(describing: result)) instead")
        }
    }
    
    func testGetLocation_DecodingError() {
        let jsonString = "{}"
        let data = jsonString.data(using: .utf8)
        let mockSession = MockURLSession(data: data, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        var result: Result<(CLLocationCoordinate2D, String), Error>?
        
        networkManager.getLocation(address: "San Francisco") { res in
            result = res
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        switch result {
        case .failure(let error as NetworkError):
            XCTAssertEqual(error, .decodingError)
        default:
            XCTFail("Expected decoding error, got \(String(describing: result)) instead")
        }
    }
    
    func testGetLocation_AddressNotFound() {
        let jsonString = """
        {
            "data": []
        }
        """
        let data = jsonString.data(using: .utf8)
        let mockSession = MockURLSession(data: data, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        var result: Result<(CLLocationCoordinate2D, String), Error>?
        
        networkManager.getLocation(address: "Unknown Place") { res in
            result = res
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        switch result {
        case .failure(let error as NetworkError):
            XCTAssertEqual(error, .addressNotFound)
        default:
            XCTFail("Expected address not found error, got \(String(describing: result)) instead")
        }
    }
    
    func testGetLocation_UnknownError() {
        let mockSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: mockSession)
        
        let expectation = XCTestExpectation(description: "Completion handler invoked")
        var result: Result<(CLLocationCoordinate2D, String), Error>?
        
        networkManager.getLocation(address: "San Francisco") { res in
            result = res
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        switch result {
        case .failure(let error as NetworkError):
            XCTAssertEqual(error, .unknownError)
        default:
            XCTFail("Expected unknown error, got \(String(describing: result)) instead")
        }
    }
}
