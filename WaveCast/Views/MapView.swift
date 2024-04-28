//
//  MapView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State var index = 0
    @StateObject private var mapAPI = MapAPI()
    @State private var searchText = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapAPI.region,
                interactionModes: .all,
                showsUserLocation: false,
                userTrackingMode: nil,
                annotationItems: mapAPI.locations)
            { location in
                MapAnnotation(coordinate: location.coordinate) {
                    ZStack {
                        Button(action: {
                            print("Button tapped for location: \(location.name)")
                        }) {
                            NavigationLink(destination: ForecastDetailView()) {
                                    Image(systemName: "mappin.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.blue)
                                }
                        }
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    TextField("Enter an address", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Button("Search") {
                        searchLocation()
                    }
                    .padding(16)
                }
                
                if isLoading {
                    ProgressView("Searching...")
                }
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
                NavigationBar(index: $index)
                    .padding(10)
            }
        }
    }
    
    private func searchLocation() {
        mapAPI.getLocation(address: searchText, delta: 0.5)
    }
}

#Preview {
    MapView()
}
