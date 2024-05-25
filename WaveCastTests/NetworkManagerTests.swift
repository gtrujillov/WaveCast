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
    
    // Test para verificar que la decodificación de WeatherResponse funciona correctamente
    func testWeatherResponseDecoding() throws {
        // Mock data para simular una respuesta JSON
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
        
        // Decodifica el JSON en un objeto WeatherResponse
        let decoder = JSONDecoder()
        let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
        
        // Verifica que la decodificación sea exitosa
        XCTAssertEqual(weatherResponse.hours.count, 1)
        XCTAssertEqual(weatherResponse.meta.cost, 1)
        XCTAssertEqual(weatherResponse.meta.params, ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"])
    }
    
    // Test para verificar que la codificación de WeatherResponse funciona correctamente
    func testWeatherResponseEncoding() throws {
        // Crea un objeto WeatherResponse con datos de ejemplo
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
        
        // Codifica el objeto WeatherResponse en JSON
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(weatherResponse)
        
        // Decodifica el JSON nuevamente en un objeto WeatherResponse para comparar
        let decodedWeatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: jsonData)
        
        // Verifica que la codificación y decodificación sean consistentes
        XCTAssertEqual(decodedWeatherResponse.hours.count, 1)
        XCTAssertEqual(decodedWeatherResponse.meta.cost, 1)
        XCTAssertEqual(decodedWeatherResponse.meta.params, ["windSpeed", "waveHeight", "wavePeriod", "waterTemperature"])
    }
    
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
