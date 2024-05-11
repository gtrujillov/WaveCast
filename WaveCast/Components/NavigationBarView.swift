//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

struct NavigationBarView: View {
    
    var title: String
    @Binding var indexSelected: Int
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                NavigationView {
                    VStack {
                        switch indexSelected {
                        case 0 :
                            MapView()
                        case 1 :
                            FavouriteView()
                        case 2 :
                            Text("Pantalla 3")
                        case 3 :
                            Text("Pantalla 4")
                        default:
                            Text("Pantalla 5")
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    NavigationBarView(title: "", indexSelected: .constant(0))
}
