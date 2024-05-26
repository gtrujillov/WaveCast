//
//  ForecastViewModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 22/5/24.
//

import Foundation

class ForecastViewModel: ObservableObject {
    // Published property to hold weather forecast data
    @Published var weather: [WeatherResponse.Hour] = []
    
    // Method to update weather data and filter only forecasts at 12 PM
    func updateWeatherData(_ weather: [WeatherResponse.Hour]) {
        let calendar = Calendar.current
        let isoFormatter = ISO8601DateFormatter()
        
        // Filter only entries at 12 PM of each day
        let filteredWeather = weather.filter { hour in
            if let date = isoFormatter.date(from: hour.time) {
                return calendar.component(.hour, from: date) == 12
            }
            return false
        }
        
        self.weather = filteredWeather
    }
    
    // Method to group and select one forecast per day
    func groupAndSelectOneForecastPerDay() -> [(String, Int, WeatherResponse.Hour)] {
        var groupedAndSelectedForecasts: [(String, Int, WeatherResponse.Hour)] = []
        let sortedWeather = weather.sorted(by: { $0.time < $1.time })
        let calendar = Calendar.current
        
        // Array with the names of the days of the week in Spanish
        let spanishWeekdaySymbols = [
            "Lunes",
            "Martes",
            "Miércoles",
            "Jueves",
            "Viernes",
            "Sábado",
            "Domingo"
        ]

        // Iterate over each hour of the forecast
        for hour in sortedWeather {
            // Try to convert the date/time string into a Date object using the ISO 8601 formatter
            if let date = ISO8601DateFormatter().date(from: hour.time) {
                let dayNumber = calendar.component(.day, from: date)
                let weekday = calendar.component(.weekday, from: date)
                // Subtract 1 because weekdays start from 1
                let dayName = spanishWeekdaySymbols[weekday - 1]
                
                // If the day hasn't been added yet, add it to the grouped forecasts
                if !groupedAndSelectedForecasts.contains(where: { $0.0 == dayName }) {
                    groupedAndSelectedForecasts.append((dayName, dayNumber, hour))
                }
            } else {
                print("Could not convert string to date")
            }
        }
        
        return groupedAndSelectedForecasts
    }
}

