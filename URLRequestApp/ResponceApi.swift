//
//  ResponceApi.swift
//  URLRequestApp
//
//  Created by Artem on 25.02.25.
//

import Foundation

struct ResponceApi: Decodable {
    let current: Weather
    let location: Location
    let forecast: ForecastData
}

struct Location: Decodable {
    let localtime: String
}

struct Weather: Decodable {
    let temp_c: Decimal
    let last_updated: String
    let wind_kph: Decimal
    let humidity: Int
}

struct ForecastData: Decodable {
    let forecastday: [QuantityDays]
}

struct QuantityDays: Decodable {
    let date: String
    let day: paramDays
}

struct paramDays: Decodable {
    let avgtemp_c: Decimal
}
