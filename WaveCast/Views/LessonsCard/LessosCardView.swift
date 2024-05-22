//
//  LessosCardView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/5/24.
//

import SwiftUI

import SwiftUI

struct LessonsCardView: View {
    
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Image(systemName: icon)
                Text(title)
                    .bold()
                    .monospaced()
            }
            Text(description)
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    LessonsCardView(
        icon: "water.waves",
        title: "wave_height_title".localized,
        description: "wave_height_description".localized
    )
}
