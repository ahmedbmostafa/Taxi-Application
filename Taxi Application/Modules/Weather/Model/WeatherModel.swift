//
//  WeatherModel.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Foundation

struct WeatherModelResponse: Decodable {
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [ListModel]?
}

struct ListModel: Decodable {
    var dt: Int?
    var main: MainModel?
    var weather: [WeatherModel]?
    var clouds: CloudsModel?
    var wind: WindModel?
}

struct MainModel: Decodable {
    var temp: Double?
    var humidity: Double?
}

struct WeatherModel: Decodable {
    var main: String?
    var weather_description: String?
    var icon : String?

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case weather_description = "description"
        case icon = "icon"
    }
}

struct CloudsModel: Decodable {
    var all: Int?
}

struct WindModel: Decodable {
    var speed: Double?
    var deg: Double?
}
