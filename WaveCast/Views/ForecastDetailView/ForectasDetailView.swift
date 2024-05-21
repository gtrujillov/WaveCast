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
        "water.waves",
        "wind"
    ]
    
    var swellHeight: Double
    var waveHeight: Double
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
                            DetailCard(data: weatherIcons[iconName] == "wind" ? swellHeight : waveHeight,
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
}

#Preview {
    ForecastDetailView(
        swellHeight: 1.0,
        waveHeight: 2.0,
        day: ""
    )
}
