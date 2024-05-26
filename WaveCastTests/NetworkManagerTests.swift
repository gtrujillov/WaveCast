//
//  NetworkManagerTests.swift
//  WaveCastTests
//
//  Created by Gonzalo Trujillo Vallejo on 26/5/24.
//

import XCTest
import CoreLocation
@testable import WaveCast

class NetworkManagerTests: XCTestCase {
    
    // MARK: - Test Methods
    
    // Test to verify that WeatherResponse decoding works correctly
    func testWeatherResponseDecoding() throws {
        // Mock data to simulate a JSON response
        let json = """
         {
             "hours": [
                 {
                     "time": "2024-05-27T00:00:00+00:00",
                     "windSpeed": {"value": 10},
                     "waveHeight": {"value": 2},
                     "wavePeriod": {"value": 8},
                     "waterTemperature": {"value": 20}
                 }
             ],
             "meta": {
                 "cost": 1,
                 "dailyQuota": 2,
                 "end": "2024-05-27T00:00:00+00:00",
                 "lat": 37.7749,
                 "lng": -122.4194,
                 "params": ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"],
                 "requestCount": 3,
                 "start": "2024-05-27T00:00:00+00:00"
             }
         }
         """.data(using: .utf8)!
        
        // Decode the JSON into a WeatherResponse object
        let decoder = JSONDecoder()
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
        
        // Verify that decoding is successful
        XCTAssertEqual(weatherResponse.hours.count, 1)
        XCTAssertEqual(weatherResponse.meta.cost, 1)
        XCTAssertEqual(weatherResponse.meta.params, ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"])
    }
    
    // Test to verify that WeatherResponse encoding works correctly
    func testWeatherResponseEncoding() throws {
        // Create a WeatherResponse object with sample data
        let weatherResponse = WeatherResponse(
            hours: [
                WeatherResponse.Hour(
                    time: "2024-05-27T00:00:00+00:00",
                    windSpeed: ["value": 10],
                    waveHeight: ["value": 2],
                    wavePeriod: ["value": 8],
                    waterTemperature: ["value": 20]
                )
            ],
            meta: WeatherResponse.Meta(
                cost: 1,
                dailyQuota: 2,
                end: "2024-05-27T00:00:00+00:00",
                lat: 37.7749,
                lng: -122.4194,
                params: ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"],
                requestCount: 3,
                start: "2024-05-27T00:00:00+00:00"
            )
        )
        
        // Encode the WeatherResponse object into JSON
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(weatherResponse)
        
        // Decode the JSON back into a WeatherResponse object for comparison
        let decodedWeatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: jsonData)
        
        // Verify that encoding and decoding are consistent
        XCTAssertEqual(decodedWeatherResponse.hours.count, 1)
        XCTAssertEqual(decodedWeatherResponse.meta.cost, 1)
        XCTAssertEqual(decodedWeatherResponse.meta.params, ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"])
    }
    
    // Test for getting weather data with decoding error
    func testGetWeather_DecodingError() async {
        let jsonString = "{}"
        let data = jsonString.data(using: .utf8)
        let mockSession = MockURLSession(data: data, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: mockSession)
        
        do {
            _ = try await networkManager.getWeather(lat: 37.7749, lng: -122.4194)
            XCTFail("Expected decoding error, but succeeded")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    // Test for getting weather data with unknown error
    func testGetWeather_UnknownError() async {
        let mockSession = MockURLSession(data: nil, urlResponse: nil, error: NSError(domain: "Test", code: 1, userInfo: nil))
        let networkManager = NetworkManager(session: mockSession)
        
        do {
            _ = try await networkManager.getWeather(lat: 37.7749, lng: -122.4194)
            XCTFail("Expected unknown error, but succeeded")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

