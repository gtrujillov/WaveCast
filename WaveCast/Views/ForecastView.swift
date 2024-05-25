//
//  ForecastView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 13/5/24.
//

import SwiftUI
import SwiftData
import CoreLocation

struct ForecastView: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Favourites.spotName) var favouriteSpots: [Favourites] = []
    
    @ObservedObject private var viewModel = ForecastViewModel()
    
    @State private var isFavourite: Bool = false
    @Binding var spotTitle: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    var onTapExpand: () -> Void
    
    init(
        spotTitle: Binding<String>,
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        weather: [WeatherResponse.Hour],
        onTapExpand: @escaping () -> Void,
        viewModel: ForecastViewModel = ForecastViewModel()
    ) {
        self._spotTitle = spotTitle
        self.latitude = latitude
        self.longitude = longitude
        self.onTapExpand = onTapExpand
        self.viewModel.updateWeatherData(weather)
    }

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(spotTitle)
                        .font(.title)
                        .monospaced()
                        .padding(20)
                    Spacer()
                    Button(action: {
                        toggleFavourite()
                    }) {
                        Image(systemName: isFavourite ? "star.fill" : "star")
                            .font(.system(size: 30))
                            .tint(.blue)
                    }
                }
                ForEach(viewModel.groupAndSelectOneForecastPerDay().sorted(by: { $0.0 < $1.0 }), id: \.2.time) { day, dayNumber, hour in
                    if let windSpeedValue = hour.windSpeed?["sg"],
                       let waveHeightValue = hour.waveHeight?["sg"],
                       let wavePeriodValue = hour.wavePeriod?["sg"],
                       let waterTemperatureValue = hour.waterTemperature?["sg"] {
                        ForecastDetailView(
                            windSpeed: windSpeedValue,
                            waveHeight: waveHeightValue,
                            wavePeriod: wavePeriodValue,
                            waterTemperature: waterTemperatureValue,
                            day: "\(day) \(dayNumber)"
                        )
                        .padding(.bottom, 20)
                    }
                }
                Spacer()
            }
            .padding()
            .ignoresSafeArea()
            .onAppear {
                isFavourite = favouriteSpots.contains(where: { $0.spotName?.lowercased() == spotTitle.lowercased() })
            }
        }
        .scrollIndicators(.hidden)
        .background(.yellowBackground)
    }
    
    private func toggleFavourite() {
        if !isFavourite {
            let favouriteSpot = Favourites(spotName: spotTitle,
                                           fillStar: true,
                                           latitude: latitude,
                                           longitude: longitude)
            if !favouriteSpots.contains(where: { $0.spotName?.lowercased() == spotTitle.lowercased() }) {
                context.insert(favouriteSpot)
                isFavourite = true
            }
        }
    }
}
