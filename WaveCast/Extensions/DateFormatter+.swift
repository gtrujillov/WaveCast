//
//  DateFormatter.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 22/5/24.
//

import Foundation

extension DateFormatter {
    
    // Returns a DateFormatter configured for WaveCast date format
    static func waveCastFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES") // Spanish locale
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX" 
        return formatter
    }
}
