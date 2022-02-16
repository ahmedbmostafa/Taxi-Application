//
//  GoogleMapService.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import Alamofire
import GoogleMaps

protocol GoogleMapServiceProtocol {
    func drawPolyLine(mapView: GMSMapView, completion: @escaping(Result<[GMSMarker], AFError>) -> Void)
}

class GoogleServiceImplementation: BaseAPI<EndPoint>, GoogleMapServiceProtocol {

    func drawPolyLine(mapView: GMSMapView, completion: @escaping(Result<[GMSMarker], AFError>) -> Void) {
        self.drawPolyLine(target: .drawPolyline, mapView: mapView) { result in
            completion(result)
        }
    }
}
