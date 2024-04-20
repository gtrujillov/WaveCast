//
//  ButtonView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct ButtonView<Destination: View>: View {
    let icon: String?
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination){
            Image(systemName: icon ?? "")
                .font(.system(size: 25))
                .foregroundColor(.black)
                .padding(15)
        }
        .background(.iconBlue)
        .cornerRadius(15)
    }
}

#Preview {
    ButtonView(
        icon: "star",
        destination: HomeView()
    )
}
