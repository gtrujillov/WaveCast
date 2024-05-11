//
//  MapView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var mapAPI = MapAPI()
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var isShowingFavourites = false // Estado para controlar si se muestra la pantalla de favoritos
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapAPI.region,
                    interactionModes: .all,
                    showsUserLocation: false,
                    userTrackingMode: nil,
                    annotationItems: mapAPI.locations)
                { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Button(action: {
                            // Toggle the flag to show favourites view
                            isShowingFavourites.toggle()
                        }) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            // Handle tap gesture if needed
                        }
                    }
                }
                .ignoresSafeArea()
                
                VStack {
                    TopBarView(searchAction: searchLocation, title: "Mapa")
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)
            }
            .fullScreenCover(isPresented: $isShowingFavourites, content: {
                FavouriteView()
            })
        }
    }
    
    private func searchLocation(_ searchText: String) {
        mapAPI.getLocation(address: searchText, delta: 0.5)
    }
}

#Preview {
    MapView()
}
