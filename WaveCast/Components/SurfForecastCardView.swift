//
//  SurfForecastCardView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct SurfForecastCardView: View {
    
    var locationTitle: String
    let weatherIcons = [
        "water.waves",
        "wind",
    ]
    
    var isFavorite: Bool
    var onTapExpand: () -> Void
    @State var data: String = "2m"
    
    var body: some View {
        HStack {
            VStack{
                HStack {
                    Text(locationTitle)
                        .font(.system(size: 15))
                        .padding([.leading, .bottom],10)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    ForEach(weatherIcons, id: \.self) { iconName in
                        HStack {
                            Image(systemName: iconName)
                                .font(.system(size: 60))
                            Text(data)
                                .font(.title)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer()
                }
            }
            .padding(20)
            Spacer()
            VStack(spacing: 40) {
                Button(action: {
                    onTapExpand()
                }) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 30))
                        .tint(.barNavy)
                }
                Button(action: {
                    onTapExpand()
                }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.subheadline)
                        .rotationEffect(.degrees(270))
                        .tint(.barNavy)
                        .padding(15)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    SurfForecastCardView(
        locationTitle: "Playa de Santa Maria del Mar",
        isFavorite: true,
        onTapExpand: {}
    )
}
