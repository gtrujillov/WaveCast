//
//  Item.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
