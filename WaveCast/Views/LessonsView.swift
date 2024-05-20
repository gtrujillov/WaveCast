//
//  LessonsView.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 20/4/24.
//

import Foundation
import SwiftUI

struct LessonsView: View {
    
    @State private var searchText: String = ""
    
    let lessons: [LessonModel] = [
        LessonModel(titleKey: "wave_height_title", descriptionKey: "wave_height_description"),
        LessonModel(titleKey: "wave_period_title", descriptionKey: "wave_period_description"),
        LessonModel(titleKey: "wave_direction_title", descriptionKey: "wave_direction_description"),
        LessonModel(titleKey: "wind_title", descriptionKey: "wind_description"),
        LessonModel(titleKey: "tide_title", descriptionKey: "tide_description"),
        LessonModel(titleKey: "water_temperature_title", descriptionKey: "water_temperature_description"),
        LessonModel(titleKey: "primary_swell_title", descriptionKey: "primary_swell_description"),
        LessonModel(titleKey: "secondary_swell_title", descriptionKey: "secondary_swell_description")
    ]
    
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
                VStack(spacing: 20) {
                    ForEach(filteredLessons) { lesson in
                        LessonsCardView(
                            title: lesson.titleKey.localized,
                            description: lesson.descriptionKey.localized
                        )
                    }
                }
                .padding()
            }
            .background(.yellowBackground)
            .searchable(text: $searchText, prompt: "Buscar...")
        }
    }
}

#Preview {
    LessonsView()
}
