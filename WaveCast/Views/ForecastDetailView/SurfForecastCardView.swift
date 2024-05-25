//
//  SurfForecastCardView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

// SurfForecastCardView.swift

import SwiftUI
import CoreLocation

struct SurfForecastCardView: View {
    
    var locationTitle: String
    var starFill: Bool
    var latitude: Double
    var longitude: Double
    var isFavorite: Bool
    var onTapExpand: () -> Void
    
    @StateObject private var viewModel = SurfForecastCardViewModel()
    
    var body: some View {
        HStack() {
            HStack() {
                Text(locationTitle)
                    .font(.system(size: 20))
                    .monospaced()
                    .multilineTextAlignment(.leading)
                Button(action: {
                    onTapExpand()
                }) {
                    Image(systemName: starFill ? "star.fill" : "star")
                        .font(.system(size: 20))
                        .tint(.blue)
                }
            }
            Spacer()
            HStack() {
                Button(action: {
                    Task {
                        await viewModel.fetchCoordinatesAndWeather(latitud: latitude, longitud: longitude)
                    }
                }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.title2)
                        .rotationEffect(.degrees(270))
                        .tint(.barNavy)
                }
                .sheet(isPresented: $viewModel.showWeatherSheet) {
                    ForecastView(
                        spotTitle: .constant(locationTitle),
                        latitude: latitude,
                        longitude: longitude,
                        weather: viewModel.weather,
                        onTapExpand: onTapExpand
                    )
                }
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct SurfForecastCardView_Previews: PreviewProvider {
    static var previews: some View {
        SurfForecastCardView(
            locationTitle: "Guincho Beach",
            starFill: true,
            latitude: 0.0,
            longitude: 0.0,
            isFavorite: true,
            onTapExpand: {}
        )
    }
}
