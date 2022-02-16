//
//  WeatherDataProvider.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Foundation

protocol WeatherDataDelegate: class {
    func onSuccess(_ weather: WeatherModelResponse)
    func onFailure(_ error: Error)
    func showLoader(show: Bool)
}

protocol WeatherDataProtocol {
    func fetchWeather()
    var delegate: WeatherDataDelegate? { get set }
}

class WeatherDataImplementation: WeatherDataProtocol {

    var weatherService: WeatherServiceProtocol?
    weak var delegate: WeatherDataDelegate?
    private var isFetching = false
    
    func fetchWeather() {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        weatherService?.fetchWeather() { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)
            switch result {
            case .success(let weatherResponse):
                guard let data = weatherResponse else {return}
                self.delegate?.onSuccess(data)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }

}
