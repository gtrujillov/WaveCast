//
//  LessonModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/5/24.
//

import Foundation

// MARK: - LessonModel
struct LessonModel: Identifiable {
    
    // MARK: Properties
    
    let id = UUID()
    let icon: String
    let titleKey: String
    let descriptionKey: String 
}
