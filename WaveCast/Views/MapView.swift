//
//  MapView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI
import MapKit
import Lottie

struct MapView: View {
    // View model for managing map data
    @ObservedObject private var viewModel = MapViewModel()
    // Selected coordinate on the map
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    init(viewModel: MapViewModel = MapViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $viewModel.region,
                interactionModes: .all,
                showsUserLocation: false,
                userTrackingMode: nil,
                annotationItems: viewModel.locations) { location in
                
                MapAnnotation(coordinate: location.coordinate) {
                    Button(action: {
                        selectedCoordinate = location.coordinate
                        viewModel.showForecastView.toggle()
                    }) {
                        // Lottie animation for map marker
                        LottieAnimation(lottieAnimationName: "mapAnimation.json")
                    }
                    .sheet(isPresented: $viewModel.showForecastView) {
                        if let weather = viewModel.weather {
                            ForecastView(
                                spotTitle: $viewModel.searchText, // Search text as spot title
                                latitude: selectedCoordinate?.latitude ?? 0.0, // Latitude of selected coordinate
                                longitude: selectedCoordinate?.longitude ?? 0.0, // Longitude of selected coordinate
                                weather: weather.hours, // Weather forecast data
                                onTapExpand: {}
                            )
                        }
                    }
                }
            }
                .edgesIgnoringSafeArea(.bottom)
                .background(.yellowBackground)
        }
        .searchable(text: $viewModel.searchText, prompt: "Buscar")
        .onSubmit(of: .search) {
            viewModel.searchLocation() 
        }
    }
}

#Preview {
    MapView() // Preview for MapView
}

