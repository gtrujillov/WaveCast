//
//  FavouriteView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct FavouriteView: View {
    
    @State private var searchText = ""
    
    let favourites = [
        "Beach",
        "Mountain",
        "City",
        "Lake",
        "Beach",
        "Mountain",
        "City",
        "Lake"
    ]
    
    var filteredFavourites: [String] {
        if searchText.isEmpty {
            return favourites
        } else {
            return favourites.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(0..<filteredFavourites.count, id: \.self) { favourite in
                        SurfForecastCardView(
                            locationTitle: filteredFavourites[favourite],
                            isFavorite: true,
                            onTapExpand: {}
                        )
                    }
                }
                .padding(15)
            }
            .scrollIndicators(.hidden)
            .background(.yellowBackground)
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            searchFavourites(newValue)
        }
    }
    
    private func searchFavourites(_ searchText: String) {
        self.searchText = searchText
    }
}

#Preview {
    FavouriteView()
}
