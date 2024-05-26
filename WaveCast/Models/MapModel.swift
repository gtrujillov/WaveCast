//
//  MapModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import MapKit

// MARK: - Address
struct Address: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let latitude, longitude: Double
    let name: String?
}

// MARK: - Location
struct Location: Identifiable {
    let id = UUID() // Unique identifier for the location
    let name: String
    let coordinate: CLLocationCoordinate2D
}
