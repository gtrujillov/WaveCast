//
//  SurfForecastCardViewModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 25/5/24.
//

import Foundation
import SwiftUI
import CoreLocation

class SurfForecastCardViewModel: ObservableObject {
    // Published properties to hold weather forecast data and flag for showing weather sheet
    @Published var weather: [WeatherResponse.Hour] = []
    @Published var showWeatherSheet = false

    // Instance of NetworkManager for making API requests
    private let networkManager = NetworkManager()
    
    // Method to fetch coordinates and weather data asynchronously
    func fetchCoordinatesAndWeather(latitude: Double, longitude: Double) async {
        do {
            // Fetch weather data using the NetworkManager
            let weatherResponse = try await networkManager.getWeather(lat: latitude, lng: longitude)
            
            // Update weather data and show weather sheet on the main queue
            DispatchQueue.main.async {
                self.weather = weatherResponse.hours
                self.showWeatherSheet = true
            }
        } catch {
            // Handle error if fetching weather data fails
            print("Error fetching weather: \(error)")
        }
    }
}
