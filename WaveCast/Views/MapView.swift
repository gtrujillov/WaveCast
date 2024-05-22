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
    
    @ObservedObject private var viewModel = MapViewModel()
    
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
                        viewModel.showForecastView.toggle()
                    }) {
                        // Lottie animation
                        LottieAnimation()
                    }
                    .sheet(isPresented: $viewModel.showForecastView) {
                        if let weather = viewModel.weather {
                            ForecastView(
                                spotTitle: $viewModel.searchText,
                                weather: weather.hours,
                                onTapExpand: {}
                            )
                        }
                    }
                }
            }
                .edgesIgnoringSafeArea(.bottom)
                .background(.yellowBackground)
        }
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search) {
            viewModel.searchLocation()
        }
    }
}

#Preview {
    MapView()
}
