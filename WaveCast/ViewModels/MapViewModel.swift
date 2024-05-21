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
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    @Published var locations: [Location] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var isShowingFavourites: Bool = false
    @Published var selectedSpotTitle: String = ""
    @Published var isSearching: Bool = false
    @Published var showForecastView: Bool = false
    @Published var weather: WeatherResponse?
    
    private var mapAPI = MapAPI()
    private var networkManager = NetworkManager()
    
    func searchLocation() {
        guard !searchText.isEmpty else { return }
        isLoading = true
        mapAPI.getLocation(address: searchText, delta: 0.5) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let coordinate, let name):
                    self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    self.locations = [Location(name: name, coordinate: coordinate)]
                    Task {
                        do {
                            let weatherResponse = try await self.networkManager.getWeather(lat: coordinate.latitude, lng: coordinate.longitude)
                            self.weather = weatherResponse
                            self.logWeatherResponse(weatherResponse)
                        } catch {
                            print("Error al obtener el clima: \(error)")
                        }
                    }
                case .failure(let error):
                    self.errorMessage = "Error al obtener la ubicación: \(error.localizedDescription)"
                    print("Error al obtener la ubicación: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func logWeatherResponse(_ weatherResponse: WeatherResponse) {
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let weatherData = try jsonEncoder.encode(weatherResponse)
            if let jsonString = String(data: weatherData, encoding: .utf8) {
                print("Respuesta JSON:", jsonString)
            } else {
                print("Error al convertir los datos a una cadena.")
            }
        } catch {
            print("Error al codificar la respuesta del clima: \(error)")
        }
    }
}
