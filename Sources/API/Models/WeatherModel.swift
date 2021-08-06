//
//  WeatherModel.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let date: Date
    let temperature: Double

    enum CodableKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
    }
}

extension CurrentWeatherModel {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodableKeys.self)
        self.date = try container.decode(Date.self, forKey: .date)
        self.temperature = try container.decode(Double.self, forKey: .temperature)
    }
}
