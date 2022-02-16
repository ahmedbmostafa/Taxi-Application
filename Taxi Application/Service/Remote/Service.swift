//
//  Service.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import Alamofire
import UIKit

protocol WeatherServiceProtocol {
    func fetchWeather(completion: @escaping (Result<WeatherModelResponse?, Error>) -> Void)
}

class WeatherServiceImplementation: BaseAPI<EndPoint>, WeatherServiceProtocol {

    func fetchWeather(completion: @escaping (Result<WeatherModelResponse?, Error>) -> Void) {
        self.fetchWeather(target: .fetchWeather) { (result) in
            completion(result)
        }
    }
}
