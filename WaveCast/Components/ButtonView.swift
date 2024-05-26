//
//  ButtonView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

// MARK: - ButtonView
struct ButtonView: View {
    
    // MARK: Properties
    
    let icon: String
    let title: String
    let action: () -> Void
    let isSelected: Bool
    
    var body: some View {
        // Button with icon and title
        Button(action: {
            action()
        }) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 25))
                    .foregroundColor(isSelected ? .white : .black) // Adjusts icon color based on selection state
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(isSelected ? .iconBurgundy : .iconBlue) // Sets background color based on selection state
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
    // Preview for ButtonView with example data
    ButtonView(icon: "star", title: "Mapa", action: {}, isSelected: false)
}
