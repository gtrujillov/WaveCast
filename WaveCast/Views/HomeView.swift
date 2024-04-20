//
//  HomeView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            NavigationBar()
                .padding(10)
        }
    }
}

#Preview {
    HomeView()
}
