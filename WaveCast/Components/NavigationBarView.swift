//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct NavigationBarView: View {
    @Binding var indexSelected: Int
    
    var body: some View {
        ZStack {
            switch indexSelected {
            case 0 :
                NavigationView {
                    VStack {
                        Text("Pantalla 1")
                    }
                }
            case 1 :
                NavigationView {
                    VStack {
                        Text("Pantalla 2")
                    }
                    .navigationTitle("Favoritos")
                }
            case 2 :
                NavigationView {
                    VStack {
                        Text("Pantalla 3")
                    }
                    .navigationTitle("Aprende")
                }
            case 3 :
                NavigationView {
                    VStack {
                        Text("Pantalla 4")
                    }
                    .navigationTitle("Noticias")
                }
            default:
                NavigationView {
                    VStack {
                        Text("Pantalla 5")
                    }
                    .navigationTitle("Configuracion")
                }
            }
        }
    }
}
#Preview {
    NavigationBarView(indexSelected: .constant(0))
}
