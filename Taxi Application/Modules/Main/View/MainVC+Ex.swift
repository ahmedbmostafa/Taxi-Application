//
//  MainVC+Ex.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit
import GoogleMaps

extension MainVC {
    func drawMap(markers: [GMSMarker]) {
        showMarker(markerList: markers)
    }

    func showActivityIndicator(show: Bool) {
        show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
    }

    func showError(error: Error) {
        UIAlertController.showAlert(withMessage: error.localizedDescription)
    }
}

extension MainVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){

        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = manager.location?.coordinate
        guard let icon = UIImage(named: "car-icon") else {return}
        addMarker(icon: icon, position: location)
    }
}
