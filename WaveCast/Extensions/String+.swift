//
//  String+.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/5/24.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func dayOfWeek() -> String {
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: self) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            dayFormatter.locale = Locale(identifier: "es_ES")
            return dayFormatter.string(from: date).capitalized
        }
        return ""
    }
}
