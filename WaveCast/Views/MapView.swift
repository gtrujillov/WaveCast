//
//  MapView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var mapAPI = MapAPI()
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var isShowingFavourites = false
    @State private var selectedSpotTitle = ""
    @State private var isSearching = false
    
    var networkManager = NetworkManager()
    @State private var weather: WeatherResponse?
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapAPI.region,
                interactionModes: .all,
                showsUserLocation: false,
                userTrackingMode: nil,
                annotationItems: mapAPI.locations)
            { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Button(action: {
                        isShowingFavourites.toggle()
                    }) {
                        Image(systemName: "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        // Handle tap gesture if needed
                    }
                }
            }
            .background(.yellowBackground)
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            searchLocation()
        }
        .sheet(isPresented: $isShowingFavourites) {
            if let weather = self.weather {
                ForecastView(spotTitle: $searchText, waveHeight: weather.hours.map { hour in
                    "\(hour.swellHeight?["sg"] ?? 0)"
                })
            }
        }
    }
    
    private func searchLocation() {
        self.isShowingFavourites = true
        mapAPI.getLocation(address: searchText, delta: 0.5) { result in
            switch result {
            case .success(let coordinate, let name):
                Task {
                    do {
                        let weatherResponse = try await networkManager.getWeather(lat: coordinate.latitude, lng: coordinate.longitude)
                        // Asignar el resultado a weather después de obtenerlo
                        self.weather = weatherResponse
                        // Convertir el objeto WeatherResponse a datos JSON
                        let jsonEncoder = JSONEncoder()
                        jsonEncoder.outputFormatting = .prettyPrinted // Opcional: formatear los datos JSON de manera legible
                        let weatherData = try jsonEncoder.encode(weatherResponse)
                        if let jsonString = String(data: weatherData, encoding: .utf8) {
                            print("Respuesta JSON:", jsonString)
                        } else {
                            print("Error al convertir los datos a una cadena.")
                        }
                    } catch {
                        print("Error al obtener el clima: \(error)")
                    }
                }
            case .failure(let error):
                print("Error al obtener la ubicación: \(error.localizedDescription)")
            }
        }
    }

}

#Preview {
    MapView()
}
