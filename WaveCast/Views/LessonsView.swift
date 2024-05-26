//
//  LessonsView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct LessonsView: View {
    
    @State private var searchText: String = "" // Search text
    
    // Array of lesson models
    let lessons: [LessonModel] = [
        LessonModel(icon: "water.waves", titleKey: "wave_height_title", descriptionKey: "wave_height_description"),
        LessonModel(icon: "clock", titleKey: "wave_period_title", descriptionKey: "wave_period_description"),
        LessonModel(icon: "wind", titleKey: "wind_title", descriptionKey: "wind_description"),
        LessonModel(icon: "thermometer", titleKey: "water_temperature_title", descriptionKey: "water_temperature_description")
    ]
    
    // Filtered lesson models based on search text
    var filteredLessons: [LessonModel] {
        if searchText.isEmpty {
            return lessons
        } else {
            return lessons.filter { lesson in
                lesson.titleKey.localized.lowercased().contains(searchText.lowercased()) ||
                lesson.descriptionKey.localized.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    if filteredLessons.isEmpty {
                        Text("No se encontraron resultados") // No results text
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(filteredLessons) { lesson in
                            LessonsCardView(
                                icon: lesson.icon,
                                title: lesson.titleKey.localized,
                                description: lesson.descriptionKey.localized
                            )
                        }
                    }
                }
                .padding()
                .padding(.bottom, 120)
            }
            .background(.yellowBackground)
            .searchable(text: $searchText, prompt: "Buscar")
        }
    }
}

#Preview {
    LessonsView() 
}

