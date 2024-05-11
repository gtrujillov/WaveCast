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
    @State private var isShowingFavourites = false
    @State private var selectedSpotTitle = ""
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapAPI.region,
                interactionModes: .all,
                showsUserLocation: false,
                userTrackingMode: nil,
                annotationItems: mapAPI.locations)
            { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Button(action: {
                        selectedSpotTitle = location.name
                        isShowingFavourites.toggle()
                    }) {
                        Image(systemName: "mappin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                    .onTapGesture {
                        // Handle tap gesture if needed
                    }
                }
            }
            .background(.yellowBackground)
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            searchLocation(newValue)
        }
        .sheet(isPresented: $isShowingFavourites) {
            ForecastView()
        }
    }
    
    private func searchLocation(_ searchText: String) {
        mapAPI.getLocation(address: searchText, delta: 0.5)
    }
}

#Preview {
    MapView()
}
