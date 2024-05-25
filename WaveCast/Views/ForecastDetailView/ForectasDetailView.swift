//
//  ForectasDetailView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 13/5/24.
//

import SwiftUI

struct ForecastDetailView: View {
    
    let weatherIcons = [
        "water.waves",
        "wind",
        "clock",
        "thermometer.snowflake"
    ]
    
    var windSpeed: Double
    var waveHeight: Double
    var wavePeriod: Double
    var waterTemperature: Double
    var day: String
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(day)
                        .font(.system(size: 20))
                        .monospaced()
                        .padding([.leading, .bottom], 10)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    ForEach(0..<weatherIcons.count, id: \.self) { iconName in
                        HStack {
                            Spacer()
                            VStack {
                                DetailCard(
                                    data: valueForIcon(iconName: weatherIcons[iconName])?.value ?? "",
                                    unit: valueForIcon(iconName: weatherIcons[iconName])?.unit ?? "",
                                    icon: weatherIcons[iconName]
                                )
                            }
                            Spacer()
                        }
                    }
                }
            }
            .padding(.vertical, 20)
        }
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func valueForIcon(iconName: String) -> (value: String, unit: String)? {
        switch iconName {
        case "wind":
            return ("\(windSpeed)", "m/s")
        case "water.waves":
            return ("\(waveHeight)", "m")
        case "clock":
            return ("\(wavePeriod)", "s")
        case "thermometer.snowflake":
            return ("\(waterTemperature)", "ºC")
        default:
            return nil
        }
    }

}

#Preview {
    ForecastDetailView(
        windSpeed: 1.2,
        waveHeight: 2.3,
        wavePeriod: 4.5,
        waterTemperature: 1.3,
        day: "Lunes 10"
    )
}
