//
//  NetworkManager.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 28/4/24.
//

import UIKit
import Foundation
import MapKit

class NetworkManager {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY  = "eee8f701585a4ae40756052bf2eb3ef7"
    
    //MARK: - MapKit API Calls
    
    func getLocation(address: String, completion: @escaping (Result<(CLLocationCoordinate2D, String), Error>) -> Void) {
        let pAddress = address.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAddress)"
        
        guard let url = URL(string: url_string) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error ?? NetworkError.unknownError))
                return
            }
            
            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else {
                completion(.failure(NetworkError.decodingError))
                return
            }
            
            if newCoordinates.data.isEmpty {
                completion(.failure(NetworkError.addressNotFound))
                return
            }
            
            let details = newCoordinates.data[0]
            let lat = details.latitude
            let lon = details.longitude
            let name = details.name ?? "Pin"
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            
            completion(.success((coordinate, name)))
        }
        .resume()
    }
    
    //MARK: - StormGlass API Calls
    
    let WEATHER_API_KEY = "9f7d60ec-4ade-11ed-a138-0242ac130002-9f7d6178-4ade-11ed-a138-0242ac130002"
    
    private func getWeather(lat: Double, lng: String) async throws -> WeatherResponse {
        let url = URL(string: "https://api.stormglass.io/v2/weather/point")!
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lng", value: String(lng)),
                URLQueryItem(name: "params", value: "waveHeight"),
                URLQueryItem(name: "params", value: "swellHeight")
            ]
            guard let finalURL = urlComponents.url else {
                throw URLError(.badURL)
            }
            
            var request = URLRequest(url: finalURL)
            request.addValue("Bearer YOUR_API_KEY", forHTTPHeaderField: "Authorization") // Reemplaza YOUR_API_KEY con tu clave de API
            
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
    case unknownError
    case decodingError
    case addressNotFound
}
