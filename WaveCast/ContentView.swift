//
//  ContentView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var indexSelected = 0
    
    @State private var titles = [
        "Mapa",
        "Favoritos",
        "Aprende",
        "Saber más"
    ]
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            NavigationBarView(title: titles[indexSelected], indexSelected: $indexSelected)
            VStack {
                Spacer()
                TabBarView(indexSelected: $indexSelected)
            }
        }
    }
}

#Preview {
    ContentView()
}
