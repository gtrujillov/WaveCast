//
//  FavouriteView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct FavouriteView: View {
    
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
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(0..<favourites.count, id: \.self) { favourite in
                        SurfForecastCardView(locationTitle: favourites[favourite], isFavorite: true, onTapExpand: {})
                    }
                }
                .padding(.top, 110)
                .padding(.horizontal, 15)
            }
            .scrollIndicators(.hidden)
            Spacer()
            VStack {
                TopBarView(searchAction: searchFavoutites, title: "Mapa")
                    .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    private func searchFavoutites(_ searchText: String) {
        print("Hola")
    }
}

#Preview {
    FavouriteView()
}
