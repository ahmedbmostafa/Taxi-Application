//
//  MainCoordinator.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit

protocol MainCoordinatorProtocol {
    func navigateToWeatherVC()
}

class MainCoordinatorImplementation: MainCoordinatorProtocol {
    weak var view: UIViewController?
    var appFlowManager: AppFlowManager?
    init(view: UIViewController?) {
        self.view = view
    }
}

extension MainCoordinatorImplementation {
    func navigateToWeatherVC() {
        appFlowManager = AppFlowManager()
        if let vc = appFlowManager?.coordinateToWeatherVC() {
            view?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
