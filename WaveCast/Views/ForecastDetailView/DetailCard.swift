//
//  DetailCard.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct DetailCard: View {
    
    var data: String
    var unit: String
    var icon: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.iconBurgundy)
            Text(data)
                .foregroundColor(.iconBurgundy)
                .bold()
            Text(unit)
                .foregroundColor(.iconBurgundy)
                .bold()
        }
        .padding(.horizontal, 15)
        .frame(width: 80, height: 120)
        .background(Color.iconBlue)
        .border(Color.black, width: 1)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.barNavy, lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
}

#Preview {
    DetailCard(
        data: "0.0",
        unit: "m/s",
        icon: "wind"
    )
}
