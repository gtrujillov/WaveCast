//
//  SearchBar.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var searchAction: () -> Void
    
    var body: some View {
        HStack {
            TextField("Enter an address", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            Button("Search") {
                searchAction()
            }
            .padding(16)
        }
    }
}

#Preview {
    SearchBarView(searchText: .constant(""),
                  searchAction: {})
}

