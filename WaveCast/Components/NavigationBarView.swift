//
//  NavigationBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 11/5/24.
//

import SwiftUI

// MARK: - NavigationBarView
struct NavigationBarView: View {
    
    // MARK: Properties
    // Title for the navigation bar
    var title: String
    // Binding to track the selected index
    @Binding var indexSelected: Int
    
    var body: some View {
        NavigationView {
            VStack {
                // Switch statement to display different views based on the selected index
                switch indexSelected {
                case 0:
                    MapView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 1:
                    FavouriteView()
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.automatic)
                case 2:
                    LessonsView()
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
    // Preview for NavigationBarView with example data
    NavigationBarView(title: "", indexSelected: .constant(0))
}
