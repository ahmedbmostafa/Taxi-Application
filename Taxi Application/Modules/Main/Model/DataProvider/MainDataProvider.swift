//
//  MainDataProvider.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Foundation
import Alamofire
import GoogleMaps

protocol GoogleMapDataDelegate: class {
    func onSuccess(_ markers: [GMSMarker])
    func onFailure(_ error: AFError)
    func showLoader(show: Bool)
}

protocol GoogleMapDataProtocol {
    func fetchPolyLine(mapView: GMSMapView)
    var delegate: GoogleMapDataDelegate? { get set }
}

class GoogleMapDataImplementation: GoogleMapDataProtocol {

    var googleMapService: GoogleMapServiceProtocol?
    private var isFetching = false
    weak var delegate: GoogleMapDataDelegate?

    func fetchPolyLine(mapView: GMSMapView) {
        isFetching = true
        delegate?.showLoader(show: isFetching)
        googleMapService?.drawPolyLine(mapView: mapView) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            self.delegate?.showLoader(show: self.isFetching)
            switch result {
            case .success(let markerList):
                self.delegate?.onSuccess(markerList)
            case .failure(let error):
                self.delegate?.onFailure(error)
            }
        }
    }
    
}
