//
//  WeatherResponse.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 15/5/24.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let hours: [Hour]
    let meta: Meta
    
    // MARK: - Hour
    struct Hour: Codable, Identifiable {
        let id: UUID
        let time: String
        var windSpeed: [String: Double]?
        var waveHeight: [String: Double]?
        var wavePeriod: [String: Double]?
        var waterTemperature: [String: Double]?
        var dayOfWeek: String
        
        enum CodingKeys: String, CodingKey {
            case time, windSpeed, waveHeight, wavePeriod, waterTemperature
        }
        
        // Initialize an Hour object with provided data
        init(
            time: String,
            windSpeed: [String: Double]?,
            waveHeight: [String: Double]?,
            wavePeriod: [String: Double]?,
            waterTemperature: [String: Double]?
        ) {
            self.id = UUID()
            self.time = time
            self.windSpeed = windSpeed
            self.waveHeight = waveHeight
            self.wavePeriod = wavePeriod
            self.waterTemperature = waterTemperature
            self.dayOfWeek = time.dayOfWeek()
        }
        
        // Initialize an Hour object from decoder
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let time = try container.decode(String.self, forKey: .time)
            let windSpeed = try container.decodeIfPresent([String: Double].self, forKey: .windSpeed)
            let waveHeight = try container.decodeIfPresent([String: Double].self, forKey: .waveHeight)
            let wavePeriod = try container.decodeIfPresent([String: Double].self, forKey: .wavePeriod)
            let waterTemperature = try container.decodeIfPresent([String: Double].self, forKey: .waterTemperature)
            self.init(time: time, windSpeed: windSpeed, waveHeight: waveHeight, wavePeriod: wavePeriod, waterTemperature: waterTemperature)
        }
        
        // Encode the Hour object
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(time, forKey: .time)
            try container.encodeIfPresent(windSpeed, forKey: .windSpeed)
            try container.encodeIfPresent(waveHeight, forKey: .waveHeight)
            try container.encodeIfPresent(wavePeriod, forKey: .wavePeriod)
            try container.encodeIfPresent(waterTemperature, forKey: .waterTemperature)
        }
    }
    
    // MARK: - Meta
    struct Meta: Codable {
        let cost: Int
        let dailyQuota: Int
        let end: String
        let lat: Double
        let lng: Double
        let params: [String]
        let requestCount: Int
        let start: String 
        
        enum CodingKeys: String, CodingKey {
            case cost, dailyQuota, end, lat, lng, params, requestCount, start
        }
    }
}

