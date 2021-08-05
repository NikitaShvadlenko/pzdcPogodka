//
//  WeatherSymbolFactory.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 05.08.2021.
//

import Foundation

enum WeatherSymbolFactory {
    static func symbolName(forTemperature temperature: Double) -> String {
        if temperature > 15.0 {
            return "thermometer.sun.fill"
        } else {
            return "thermometer.snowflake"
        }
    }
}
