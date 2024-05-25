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
    @Published var weather: [WeatherResponse.Hour] = []
    @Published var showWeatherSheet = false

    private let networkManager = NetworkManager()
    
    func fetchCoordinatesAndWeather(latitud: Double, longitud: Double) async {
        do {
            let weatherResponse = try await networkManager.getWeather(lat: latitud, lng: longitud)
            DispatchQueue.main.async {
                self.weather = weatherResponse.hours
                self.showWeatherSheet = true
            }
        } catch {
            print("Error al obtener el clima: \(error)")
        }
    }
}
