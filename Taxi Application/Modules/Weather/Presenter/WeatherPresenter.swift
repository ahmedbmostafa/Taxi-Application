//
//  WeatherPresenter.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Alamofire

protocol WeatherPresenterProtocol {
    func didLoad()
}

class WeatherPresenter: WeatherPresenterProtocol{

    var dataProvider: WeatherDataProtocol?
    weak private var view : FetchWeatherProtocol?

    init(dataProvider:WeatherDataProtocol, view: FetchWeatherProtocol){
        self.dataProvider = dataProvider
        self.view = view
    }

    func didLoad() {
        dataProvider?.fetchWeather()
    }
    
}

extension WeatherPresenter: WeatherDataDelegate {

    func showLoader(show: Bool) {
        view?.showActivityIndicator(show: show)
    }

    func onSuccess(_ weather: WeatherModelResponse) {
        view?.fetchWeather(weather: weather)
    }

    func onFailure(_ error: Error) {
        view?.showError(error: error)
    }
}
