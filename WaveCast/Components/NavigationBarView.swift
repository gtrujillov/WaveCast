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
                case 0:
                    MapView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
                case 1:
                    EmptyView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
                case 2:
                    FavouriteView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
                case 3:
                    LessonsView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
                case 4:
                    EmptyView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
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
