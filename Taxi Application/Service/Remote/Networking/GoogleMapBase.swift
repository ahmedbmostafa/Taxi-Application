//
//  GoogleMapBase.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import GoogleMaps
import Alamofire
import SwiftyJSON


extension BaseAPI {

    func drawPolyLine (target: T, mapView: GMSMapView, completion: @escaping(Result<[GMSMarker], AFError>) -> Void) {
        AF.request(target.base + target.path).responseJSON { (response) in
            switch response.result {
            case .success:
                mapView.clear()
                var markerList = [GMSMarker]()
                guard let data = response.data else {return}
                self.decodeData(data: data, mapView: mapView)

                guard let icon = UIImage(named: "car-icon") else {return}
                let sourceMarker = self.addMarker(mapView: mapView, icon: icon, position: sourceLocaltion)
                markerList.append(sourceMarker)

                guard let iconDestination = UIImage(named: "Group 7") else {return}
                let destionationMarker = self.addMarker(mapView: mapView, icon: iconDestination, position: destinationLocation)
                markerList.append(destionationMarker)
                completion(.success(markerList))
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }

    func decodeData(data: Data, mapView: GMSMapView) {
        do {
            let jsonData = try JSON(data: data)
            let routes = jsonData["routes"].arrayValue
            if routes.count != 0 {
                let routeOverviewPolyline = routes[0]["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 3
                polyline.strokeColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
                polyline.map = mapView
            } else {
                print("Please Add Google API key to draw Polyline |-> Service -> Remote -> Networking -> Constants File")
            }
        } catch let error {
            print("error")
            print(error.localizedDescription)
        }
    }

    func addMarker(mapView: GMSMapView, icon: UIImage, position: CLLocationCoordinate2D!) -> GMSMarker {
        let marker = GMSMarker()
        marker.position = position
        marker.icon = icon
        marker.map = mapView
        return marker
    }
}
