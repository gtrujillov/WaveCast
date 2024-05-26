//
//  String+.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/5/24.
//

import Foundation

// MARK: - String Extension
extension String {
    
    // Localizes the string
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    // Returns the day of the week for a given ISO8601 date string
    func dayOfWeek() -> String {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: self) else { return "" }
        
        // Set up date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES") // Spanish locale
        dateFormatter.dateFormat = "EEEE" // Format for day of the week
        
        // Return the day of the week
        return dateFormatter.string(from: date)
    }
}
