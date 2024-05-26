//
//  MapViewModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 21/5/24.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    @Published var locations: [Location] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var isShowingFavourites: Bool = false
    @Published var isSearching: Bool = false
    @Published var showForecastView: Bool = false
    @Published var weather: WeatherResponse?
    
    // MARK: - Private Properties
    
    private var mapAPI = MapAPI()
    private var networkManager = NetworkManager()
    
    // MARK: - Methods
    
    // Initiates a location search based on the entered text
    func searchLocation() {
        guard !searchText.isEmpty else { return }
        // Clear existing locations
        locations = []
        // Indicate loading state
        isLoading = true
        
        // Fetch location coordinates and weather data
        mapAPI.getLocation(address: searchText, delta: 0.5) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let coordinate, let name):
                    // Update map region and locations
                    self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    self.locations = [Location(name: name, coordinate: coordinate)]
                    
                    // Fetch weather data asynchronously
                    Task {
                        do {
                            let weatherResponse = try await self.networkManager.getWeather(lat: coordinate.latitude, lng: coordinate.longitude)
                            self.weather = weatherResponse
                            self.logWeatherResponse(weatherResponse)
                        } catch {
                            print("Error fetching weather: \(error)")
                        }
                    }
                case .failure(let error):
                    // Handle location search failure
                    self.errorMessage = "Error fetching location: \(error.localizedDescription)"
                    print("Error fetching location: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // Logs the weather response in a readable JSON format
    private func logWeatherResponse(_ weatherResponse: WeatherResponse) {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let weatherData = try jsonEncoder.encode(weatherResponse)
            if let jsonString = String(data: weatherData, encoding: .utf8) {
                print("JSON Response:", jsonString)
            } else {
                print("Error converting data to string.")
            }
        } catch {
            print("Error encoding weather response: \(error)")
        }
    }
}

