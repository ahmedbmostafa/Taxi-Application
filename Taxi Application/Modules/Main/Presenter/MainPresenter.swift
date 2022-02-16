//
//  MainPresenter.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Foundation
import GoogleMaps
import Alamofire

protocol MainPresenterProtocol {
    var dataProvider: GoogleMapDataProtocol? {get}
    var coordinator: MainCoordinatorProtocol? {get}
    func didLoad(mapView: GMSMapView)
}

class MainPresenter: MainPresenterProtocol{

    var dataProvider: GoogleMapDataProtocol?
    var coordinator: MainCoordinatorProtocol?
    weak private var view : DrawPolyLineProtocol?

    init(dataProvider:GoogleMapDataProtocol, coordinator: MainCoordinatorProtocol, view: DrawPolyLineProtocol){
        self.dataProvider = dataProvider
        self.view = view
    }

    func didLoad(mapView: GMSMapView){
        dataProvider?.fetchPolyLine(mapView: mapView)
    }
}


extension MainPresenter: GoogleMapDataDelegate {
    
    func showLoader(show: Bool) {
        view?.showActivityIndicator(show: show)
    }

    func onSuccess(_ markers: [GMSMarker]) {
        view?.drawMap(markers: markers)
    }

    func onFailure(_ error: AFError) {
        view?.showError(error: error)
    }
}
