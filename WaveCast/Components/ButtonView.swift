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
    
    var body: some View {
        Button(action: {
            // Acción que se realizará al presionar el botón
        }) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(.black)
                .padding(10)
                .background(.iconBlue)
                .cornerRadius(15)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(icon: "star")
    }
}
