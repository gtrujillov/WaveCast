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
    var wavePeriod: Double // Variable adicional
    var waterTemperature: Double // Variable adicional
    var day: String
    
    var body: some View {
        HStack {
            VStack{
                HStack {
                    Text(day)
                        .font(.system(size: 15))
                        .padding([.leading, .bottom],10)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    ForEach(0..<weatherIcons.count, id: \.self) { iconName in
                        HStack {
                            Spacer()
                            DetailCard(
                                data: valueForIcon(iconName: weatherIcons[iconName]) ?? 0.0,
                                icon: weatherIcons[iconName]
                            )
                            Spacer()
                        }
                    }
                }
            }
            .padding(.vertical, 25)
        }
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    // Función para asociar un valor dependiendo del icono
    func valueForIcon(iconName: String) -> Double? {
        switch iconName {
        case "wind":
            return windSpeed
        case "water.waves":
            return waveHeight
        case "clock":
            return wavePeriod
        case "thermometer.snowflake":
            return waterTemperature
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
        day: ""
    )
}
