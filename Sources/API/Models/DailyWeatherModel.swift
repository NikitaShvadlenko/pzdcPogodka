//
//  DailyWeatherModel.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation

struct DailyWeatherModel: Decodable {
    let date: Date
    let temperature: Temperature

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case temperature = "temp"
    }
}
