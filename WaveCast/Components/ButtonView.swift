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
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(.black)
                .padding(10)
                .background(.iconBlue)
                .cornerRadius(15)
                .shadow(color: .black, radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    ButtonView(icon: "star", action: {})
}
