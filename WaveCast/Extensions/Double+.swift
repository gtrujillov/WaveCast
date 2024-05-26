//
//  Double.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 21/5/24.
//

import Foundation

extension Double {
    
    // Converts a double to a string rounded to the specified number of decimal places
    func roundedToString(decimalPlaces: Int = 2) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
