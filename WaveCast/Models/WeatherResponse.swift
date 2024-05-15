//
//  WeatherResponse.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 15/5/24.
//

import Foundation

struct WeatherResponse: Codable {
    struct Hour: Codable {
        let time: String
        let waveHeight: [String: Double]
        let swellHeight: [String: Double]
    }
    let hours: [Hour]
    let meta: Meta
}

//MARK: - Metadatos de la consulta a la API

struct Meta: Codable {
    let cost: Int
    let dailyQuota: Int
    let end: String
    let lat: Double
    let lng: Double
    let params: [String]
    let requestCount: Int
    let start: String
}
