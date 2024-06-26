//
//  NetworkManager.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 28/4/24.
//

import Foundation
import MapKit

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidURL
    case unknownError
    case decodingError
    case addressNotFound
}

// MARK: - NetworkManager
class NetworkManager {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY  = "eee8f701585a4ae40756052bf2eb3ef7"
    private let session: URLSession
    
    // MARK: - Initialization
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - MapKit API Calls
    
    // Fetches location coordinates for a given address
    func getLocation(address: String, completion: @escaping (Result<(CLLocationCoordinate2D, String), Error>) -> Void) {
        // URL encode the address
        let pAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        guard let url = URL(string: url_string) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        // Perform data task to make API call
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error making request: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            // Decode response data
            do {
                let newCoordinates = try JSONDecoder().decode(Address.self, from: data)
                
                if newCoordinates.data.isEmpty {
                    print("No coordinates found in response")
                    completion(.failure(NetworkError.addressNotFound))
                    return
                }
                
                // Extract coordinate and name from response
                let details = newCoordinates.data[0]
                let lat = details.latitude
                let lon = details.longitude
                let name = details.name ?? "Pin"
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                completion(.success((coordinate, name)))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(NetworkError.decodingError))
            }
        }
        .resume()
    }
    
    // MARK: - StormGlass API Calls
    
    let WEATHER_API_KEY = "9f7d60ec-4ade-11ed-a138-0242ac130002-9f7d6178-4ade-11ed-a138-0242ac130002"
    
    // Fetches weather data from StormGlass API
    func getWeather(lat: Double, lng: Double) async throws -> WeatherResponse {
        let url = URL(string: "https://api.stormglass.io/v2/weather/point")!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        let calendar = Calendar.current
        let today = Date()
        let startOfDay = calendar.startOfDay(for: today)
        
        // Obtain end date and time (five days ahead at 23:59 PM)
        var dateComponents = DateComponents()
        dateComponents.day = 5
        let endOfDay = calendar.date(byAdding: dateComponents, to: startOfDay)!
        
        let isoFormatter = ISO8601DateFormatter()
        let start = isoFormatter.string(from: startOfDay)
        let end = isoFormatter.string(from: endOfDay)
        
        // Configure URL parameters
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lng", value: String(lng)),
            URLQueryItem(name: "params", value: "windSpeed,waveHeight,wavePeriod,waterTemperature"),
            URLQueryItem(name: "start", value: start),
            URLQueryItem(name: "end", value: end)
        ]
        
        // Construct final URL
        guard let finalURL = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        // Create request with API key
        var request = URLRequest(url: finalURL)
        request.addValue(WEATHER_API_KEY, forHTTPHeaderField: "Authorization")
        
        // Perform async data request
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // Decode and return weather response
        let fullResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        return fullResponse
    }
}

