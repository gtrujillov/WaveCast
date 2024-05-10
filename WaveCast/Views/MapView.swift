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
                            print("Button tapped for location: \(location.name)")
                        }) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                        }
                        .onTapGesture {
                            // Realiza la navegación aquí si es necesario
                        }
                    }
                }
                .ignoresSafeArea()
                
                VStack {
                    SearchBarView(searchText: $searchText, searchAction: searchLocation)
                        .padding(.top, 16) // Espacio en la parte superior
                        .padding(.horizontal)
                    
                    if isLoading {
                        ProgressView("Searching...")
                    }
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                    Spacer()
                }
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
