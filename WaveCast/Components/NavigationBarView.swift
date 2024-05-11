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
    let gradient = LinearGradient(colors: [Color.orange, Color.green], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
            VStack {
                switch indexSelected {
                case 0 :
                    MapView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.large)
                case 1 :
                    FavouriteView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.large)
                case 2 :
                    LessonsView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.large)
                case 3 :
                    NewsView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.large)
                default:
                    Text("")
                }
            }
        }
    }
}
#Preview {
    NavigationBarView(title: "", indexSelected: .constant(0))
}
