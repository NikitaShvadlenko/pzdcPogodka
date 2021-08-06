//
//  WeatherResponse.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation

struct WeatherResponse: Decodable {
    let currentWeather: CurrentWeatherModel
    let forecasts: [DailyWeatherModel]

    enum CodingKeys: String, CodingKey {
        case currentWeather = "current"
        case forecasts = "daily"
    }
}
