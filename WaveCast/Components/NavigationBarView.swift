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
        NavigationView {
            VStack {
                switch indexSelected {
                case 0:
                    MapView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 1:
                    EmptyView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 2:
                    FavouriteView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 3:
                    LessonsView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 4:
                    EmptyView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
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
