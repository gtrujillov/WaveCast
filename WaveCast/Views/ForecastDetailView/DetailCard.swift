//
//  DetailCard.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct DetailCard: View {
    
    @State var data: Double
    @State var icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .padding(.top, 20)
                .font(.system(size: 30))
            Text(data.roundedToString(decimalPlaces: 2))
                .padding(.vertical, 20)
        }
        .padding(.horizontal, 15)
        .background(Color.iconBlue)
        .border(Color.black, width: 1)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.black, lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}

#Preview {
    DetailCard(data: 0.0, icon: "wind")
}
