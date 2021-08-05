//
//  OpenWeatherRoute.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation
import Moya

enum OpenWeatherRoute {
    case oneCall(latitude: Double, longitude: Double)
}

extension OpenWeatherRoute: TargetType {
    var baseURL: URL {
        "https://api.openweathermap.org/data/2.5"
    }

    var path: String {
        switch self {
        case .oneCall:
            return "onecall"
        }
    }

    var method: Moya.Method {
        switch self {
        case .oneCall: return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .oneCall(latitude, longitude):
            let parameters: [String: Any] = [
                "lat": latitude,
                "lon": longitude,
                "exclude": "minutely,hourly,alerts",
                "appid": "abc", // this value is private. Will be removed in commit. You should set your own API key.
                // Register on https://openweathermap.org and generate key
                "units": "metric"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
