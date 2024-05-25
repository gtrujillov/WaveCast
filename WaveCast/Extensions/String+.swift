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
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: self) else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_ES")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}
