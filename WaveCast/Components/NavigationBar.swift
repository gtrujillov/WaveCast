//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct NavigationBar: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack(spacing: .zero) {
                    Spacer()
                    ButtonView(icon: "map.circle", destination: MapView())
                    Spacer()
                    ButtonView(icon: "star.fill", destination: FavouriteView())
                    Spacer()
                    ButtonView(icon: "info.circle.fill", destination: LessonsView())
                    Spacer()
                    ButtonView(icon: "newspaper.fill", destination: NewsView())
                    Spacer()
                }
                .padding(20)
                .background(.barNavy)
            .cornerRadius(25)
            }
        }
        .background(.red)
    }
}

#Preview {
    NavigationBar()
}
