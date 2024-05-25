//
//  ButtonView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    let icon: String
    let title: String
    let action: () -> Void
    let isSelected: Bool
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 25))
                    .foregroundColor(isSelected ? .white : .black)
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(isSelected ? .iconBurgundy : .iconBlue)
                    .cornerRadius(15)
                    .shadow(color: .black, radius: 5, x: 0, y: 2)
                Text(title)
                    .foregroundColor(.white)
                    .padding(2)
                    .font(.system(size: 8))
                    .fontDesign(.monospaced)
            }
        }
    }
}

#Preview {
    ButtonView(icon: "star", title: "Mapa", action: {}, isSelected: false)
}
