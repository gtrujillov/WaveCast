//
//  Favourites.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 25/5/24.
//
import Foundation
import SwiftData
import CoreLocation

// MARK: - Favourites
@Model
class Favourites {
    
    // MARK: Properties
    
    var spotName: String?
    var fillStar: Bool?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees? 
    
    // MARK: Initialization
    
    // Initializes a Favourites object with optional parameters
    init(spotName: String? = nil, fillStar: Bool? = nil, latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil) {
        self.spotName = spotName
        self.fillStar = fillStar
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: Methods
    
    // Checks if the spot name contains the search text (case-insensitive)
    func localizedCaseInsensitiveContains(_ searchText: String) -> Bool {
        return ((spotName?.lowercased().contains(searchText.lowercased())) != nil)
    }
}

