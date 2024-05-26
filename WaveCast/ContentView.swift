//
//  ContentView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    // MARK: State Variables
    
    // Tracks the selected index in the tab view
    @State var indexSelected = 0
    
    // State variables for titles and search text
    @State private var titles = [
        "Mapa",
        "Favoritos",
        "Aprende",
        "Saber más"
    ]
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            // Navigation Bar View with dynamic title
            NavigationBarView(title: titles[indexSelected], indexSelected: $indexSelected)
            VStack {
                Spacer()
                // Tab Bar View with dynamic index selection
                TabBarView(indexSelected: $indexSelected)
            }
        }
    }
}

#Preview {
    // Preview for ContentView
    ContentView()
}
