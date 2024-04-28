//
//  ContentView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var index = 0
   
    var body: some View {
        VStack {
            NavigationBar(index: $index)
        }
    }
}

#Preview {
   ContentView()
}
