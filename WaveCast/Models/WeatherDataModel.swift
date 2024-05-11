//
//  WeatherDataModel.swift
//  WaveCast
//
//  Created by Gonzalo Trujillo Vallejo on 14/5/24.
//

import Foundation

struct WeatherData {
    let current: Current
    let daily: Daily

    struct Current {
        let time: Date
        let waveHeight: Float
        let waveDirection: Float
        let wavePeriod: Float
        let windWaveHeight: Float
        let windWaveDirection: Float
        let windWavePeriod: Float
        let windWavePeakPeriod: Float
        let swellWaveHeight: Float
        let swellWaveDirection: Float
        let swellWavePeriod: Float
        let swellWavePeakPeriod: Float
    }

    struct Daily {
        let time: [Date]
        let waveHeightMax: [Float]
        let waveDirectionDominant: [Float]
        let wavePeriodMax: [Float]
        let windWaveHeightMax: [Float]
        let windWaveDirectionDominant: [Float]
        let windWavePeakPeriodMax: [Float]
        let swellWavePeriodMax: [Float]
    }
}
