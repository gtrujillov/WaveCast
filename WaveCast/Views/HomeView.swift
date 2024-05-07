//
//  HomeView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Contenido de la pantalla principal")
                CustomNavigationBar()
                    .padding(10)
            }
        }
        .navigationBarTitle("App Name")
    }
}

#Preview {
    HomeView()
}
