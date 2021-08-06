//
//  Temperature.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation

struct Temperature: Decodable {
    let day: Double
    let minimum: Double
    let maximum: Double
    let night: Double
    let evening: Double
    let morning: Double

    enum CodingKeys: String, CodingKey {
        case day
        case minimum = "min"
        case maximum = "max"
        case night
        case evening = "eve"
        case morning = "morn"
    }
}
