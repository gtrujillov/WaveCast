//
//  MapAPI.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 28/4/24.
//

import UIKit
import Foundation
import MapKit

class MapAPI: ObservableObject {
    // MARK: - Published Properties
    
    @Published var region: MKCoordinateRegion
    @Published var locations: [Location] = []
    
    // MARK: - Private Properties
    
    private let networkManager = NetworkManager() 
    
    // MARK: - Initialization
    
    init() {
        // Default region (centered at London)
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.50, longitude: -0.1275),
                                         span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        
        // Default location (London)
        self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 51.50, longitude: -0.1275)), at: 0)
    }
    
    // MARK: - Methods
    
    // Fetches location coordinates for a given address and updates the map
    func getLocation(address: String, delta: Double, completion: @escaping (Result<(CLLocationCoordinate2D, String), Error>) -> Void) {
        networkManager.getLocation(address: address) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let (coordinate, name)):
                    // Update the map region to focus on the fetched location
                    self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                    
                    // Create a new location object for the fetched location
                    let newLocation = Location(name: name, coordinate: coordinate)
                    
                    // Replace existing location array with the new location
                    self.locations.removeAll()
                    self.locations.insert(newLocation, at: 0)
                    
                    print("Successfully retrieved location.")
                    completion(.success((coordinate, name)))
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
    }
}

