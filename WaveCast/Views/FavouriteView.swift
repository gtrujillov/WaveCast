//
//  FavouriteView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI
import SwiftData

struct FavouriteView: View {
    @Environment(\.modelContext) var context
    @State private var searchText = ""
    @State private var isDeleted: Bool?
    @Query(sort: \Favourites.spotName) var favouriteSpots: [Favourites] = []
    
    var filteredFavourites: [Favourites] {
        if searchText.isEmpty {
            return favouriteSpots
        } else {
            return favouriteSpots.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if favouriteSpots.isEmpty {
                        Text("No tienes spots de surf favoritos")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(filteredFavourites) { favourite in
                            SurfForecastCardView(
                                locationTitle: favourite.spotName ?? "",
                                starFill: favourite.fillStar ?? false,
                                latitude: favourite.latitude ?? 0.0,
                                longitude: favourite.longitude ?? 0.0,
                                isFavorite: true) {
                                    context.delete(favourite)
                                }
                        }
                    }
                }
                .padding(10)
            }
            .padding()
            .padding(.bottom, 120)
            .scrollIndicators(.hidden)
            .background(.yellowBackground)
        }
        .searchable(text: $searchText, prompt: "Buscar")
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
