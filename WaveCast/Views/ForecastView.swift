//
//  ForecastView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 13/5/24.
//

import SwiftUI

struct ForecastView: View {
    
    @Binding var spotTitle: String
    @State var weather: [WeatherResponse.Hour] = []
    var onTapExpand: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        onTapExpand()
                    }) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 30))
                            .tint(.barNavy)
                    }
                    Text(spotTitle)
                        .font(.title)
                        .fontDesign(.monospaced)
                        .padding(20)
                    Spacer()
                }
                ForEach(weather) { hour in
                    if let swellHeightValue = hour.swellHeight?["sg"], let waveHeightValue = hour.waveHeight?["noaa"] {
                        ForecastDetailView(
                            swellHeight: swellHeightValue,
                            waveHeight: waveHeightValue,
                            day: ""
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
    ForecastView(spotTitle: .constant(""), onTapExpand: {})
}
