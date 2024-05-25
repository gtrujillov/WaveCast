//
//  ForecastViewModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 22/5/24.
//

import Foundation

class ForecastViewModel: ObservableObject {
    @Published var weather: [WeatherResponse.Hour] = []
    
    // Método para actualizar los datos meteorológicos y filtrar solo los pronósticos a las 12 PM
    func updateWeatherData(_ weather: [WeatherResponse.Hour]) {
        let calendar = Calendar.current
        let isoFormatter = ISO8601DateFormatter()
        
        // Filtrar solo las entradas a las 12 PM de cada día
        let filteredWeather = weather.filter { hour in
            if let date = isoFormatter.date(from: hour.time) {
                return calendar.component(.hour, from: date) == 12
            }
            return false
        }
        
        self.weather = filteredWeather
    }
    
    // Método para agrupar y seleccionar un pronóstico por día
    func groupAndSelectOneForecastPerDay() -> [(String, Int, WeatherResponse.Hour)] {
        var groupedAndSelectedForecasts: [(String, Int, WeatherResponse.Hour)] = []
        let sortedWeather = weather.sorted(by: { $0.time < $1.time })
        let calendar = Calendar.current
        
        // Array con los nombres de los días de la semana en español
        let spanishWeekdaySymbols = [
            "Domingo",
            "Lunes",
            "Martes",
            "Miércoles",
            "Jueves",
            "Viernes",
            "Sábado"
        ]
        
        // Iterar sobre cada hora del pronóstico
        for hour in sortedWeather {
            // Intentar convertir la cadena de fecha/hora en un objeto Date utilizando el formateador ISO 8601
            if let date = ISO8601DateFormatter().date(from: hour.time) {
                let dayNumber = calendar.component(.day, from: date)
                let weekday = calendar.component(.weekday, from: date)
                let dayName = spanishWeekdaySymbols[weekday - 1] // Restamos 1 porque los días de la semana comienzan desde 1
                
                if !groupedAndSelectedForecasts.contains(where: { $0.0 == dayName }) {
                    groupedAndSelectedForecasts.append((dayName, dayNumber, hour))
                }
            } else {
                print("No se pudo convertir la cadena a fecha")
            }
        }
        
        return groupedAndSelectedForecasts
    }
}
