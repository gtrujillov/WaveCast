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
}

enum NetworkError: Error {
    case invalidURL
    case unknownError
    case decodingError
    case addressNotFound
}
