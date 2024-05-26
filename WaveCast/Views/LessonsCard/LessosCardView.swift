//
//  LessosCardView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/5/24.
//

import SwiftUI

// View for displaying lessons card
struct LessonsCardView: View {
    
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            // Icon and title
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.iconBurgundy)
                Text(title)
                    .bold()
                    .monospaced()
            }
            // Description
            Text(description)
                .multilineTextAlignment(.leading)
        }
        // Styling
        .padding(16)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

// Preview for LessonsCardView
#Preview {
    LessonsCardView(
        icon: "water.waves",
        title: "wave_height_title".localized,
        description: "wave_height_description".localized
    )
}
