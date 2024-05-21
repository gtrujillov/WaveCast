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
        var swellHeight: [String: Double]?
        var waveHeight: [String: Double]?

        enum CodingKeys: String, CodingKey {
            case time, swellHeight, waveHeight
        }

        init(time: String, swellHeight: [String: Double]?, waveHeight: [String: Double]?) {
            self.id = UUID()
            self.time = time
            self.swellHeight = swellHeight?.mapValues { $0.rounded(toPlaces: 1) }
            self.waveHeight = waveHeight?.mapValues { $0.rounded(toPlaces: 1) }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let time = try container.decode(String.self, forKey: .time)
            let swellHeight = try container.decodeIfPresent([String: Double].self, forKey: .swellHeight)
            let waveHeight = try container.decodeIfPresent([String: Double].self, forKey: .waveHeight)
            self.init(time: time, swellHeight: swellHeight, waveHeight: waveHeight)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(time, forKey: .time)
            try container.encodeIfPresent(swellHeight, forKey: .swellHeight)
            try container.encodeIfPresent(waveHeight, forKey: .waveHeight)
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
