//
//  Favourites.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 25/5/24.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Favourites {
    var spotName: String?
    var fillStar: Bool?
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    init(spotName: String? = nil, fillStar: Bool? = nil, latitude: CLLocationDegrees? = nil, longitude: CLLocationDegrees? = nil) {
        self.spotName = spotName
        self.fillStar = fillStar
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func localizedCaseInsensitiveContains(_ searchText: String) -> Bool {
        return ((spotName?.lowercased().contains(searchText.lowercased())) != nil)
    }
}
