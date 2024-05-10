//
//  ContentView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI

struct ContentView: View {
        
    @State var indexSelected = 0
    
    var body: some View {
        VStack {
            NavigationBarView(indexSelected: $indexSelected)
            TabBarView(indexSelected: $indexSelected)
        }
    }
}

#Preview {
    ContentView()
}
