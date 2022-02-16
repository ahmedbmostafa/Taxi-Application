//
//  AppFlowManager.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import UIKit
import CoreLocation


class AppFlowManager {

    func start(navigationController: UINavigationController) {
        let vc = creatMainVC()
        navigationController.pushViewController(vc, animated: false)
    }
}

extension AppFlowManager {

    func creatMainVC() -> UIViewController {
        let mainVC = MainVC.instantiate(fromAppStoryboard: .Main)
        let dataProvider = GoogleMapDataImplementation()
        dataProvider.googleMapService = GoogleServiceImplementation()
        let coordinator = MainCoordinatorImplementation(view: mainVC)
        let presenter = MainPresenter(dataProvider: dataProvider, coordinator: coordinator, view: mainVC)
        dataProvider.delegate = presenter
        presenter.dataProvider = dataProvider
        presenter.coordinator = coordinator
        mainVC.presenter = presenter
        mainVC.locationManager = CLLocationManager()
        mainVC.locationManager.delegate = mainVC
        return mainVC
    }

    func coordinateToWeatherVC() -> UIViewController {
        let weatherVC = WeatherVC.instantiate(fromAppStoryboard: .Main)
        let dataProvider = WeatherDataImplementation()
        dataProvider.weatherService = WeatherServiceImplementation()
        let presenter = WeatherPresenter(dataProvider: dataProvider, view: weatherVC)
        dataProvider.delegate = presenter
        presenter.dataProvider = dataProvider
        weatherVC.presenter = presenter
        return weatherVC
    }
}
