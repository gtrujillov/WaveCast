//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct CustomNavigationBar: View {
    var body: some View {
        HStack {
            NavigationLink(destination: HomeView()) {
                ButtonView(icon: "map.circle")
            }
            Spacer()
            NavigationLink(destination: ForecastDetailView()) {
                ButtonView(icon: "star.fill")
            }
            Spacer()
            NavigationLink(destination: MapView()) {
                ButtonView(icon: "info.circle.fill")
            }
            Spacer()
            NavigationLink(destination: LessonsView()) {
                ButtonView(icon: "newspaper.fill")
            }
        }
        .padding(15)
        .background(.barNavy)
        .cornerRadius(25)
    }
}


#Preview {
    CustomNavigationBar()
}
