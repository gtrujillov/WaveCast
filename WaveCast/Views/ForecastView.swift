//
//  ForecastView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 13/5/24.
//

import SwiftUI

struct ForecastView: View {
    
    @Binding var spotTitle: String
    var onTapExpand: () -> Void
    @ObservedObject private var viewModel = ForecastViewModel()
    
    init(spotTitle: Binding<String>, weather: [WeatherResponse.Hour], onTapExpand: @escaping () -> Void, viewModel: ForecastViewModel = ForecastViewModel()) {
        self._spotTitle = spotTitle
        self.onTapExpand = onTapExpand
        self.viewModel.updateWeatherData(weather)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(spotTitle)
                        .font(.title)
                        .fontDesign(.monospaced)
                        .padding(20)
                    Spacer()
                    Button(action: {
                        onTapExpand()
                    }) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .tint(.barNavy)
                    }
                }
                ForEach(viewModel.groupAndSelectOneForecastPerDay().sorted(by: { $0.0 < $1.0 }), id: \.2.time) { day, dayNumber, hour in
                    if let windSpeedValue = hour.windSpeed?["sg"], let waveHeightValue = hour.waveHeight?["noaa"], let wavePeriodValue = hour.wavePeriod?["noaa"], let waterTemperatureValue = hour.waterTemperature?["noaa"] {
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
        }
        .background(.yellowBackground)
    }
}

#Preview {
    ForecastView(
        spotTitle: .constant("Guincho"),
        weather: [],
        onTapExpand: {}
    )
}

