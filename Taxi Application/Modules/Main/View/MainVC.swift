//
//  MainVC.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import UIKit
import GoogleMaps

protocol DrawPolyLineProtocol: class {
    func drawMap(markers: [GMSMarker])
    func showActivityIndicator(show: Bool)
    func showError(error : Error)
}

class MainVC: UIViewController, DrawPolyLineProtocol{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var sourceMainView: RoundViewBorder!
    @IBOutlet weak var destinationMainView: RoundViewBorder!
    @IBOutlet weak var sourceView: RoundView!
    @IBOutlet weak var destinationView: RoundView!
    
    
    var locationManager: CLLocationManager!
    var presenter : MainPresenterProtocol!
    var activityIndicator: ActivityIndicatorStates!
    private var sourceTapped = false
    private var destinationTapped = false

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Taxi"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.5647058824, blue: 0.6901960784, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = ActivityIndicator()
        addSearchBtn()
        checkConnection()
    }

    func checkConnection() {
        if Connectivity.isConnectedToInternet {
            addGestureToLbl()
            setUpMapView()
        } else {
            self.view.makeToast("Check internet connection")
        }
    }

    func addSearchBtn() {
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "search"), for: .normal)
        searchBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        searchBtn.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
        let searchBtnItem = UIBarButtonItem()
        searchBtnItem.customView = searchBtn
        self.navigationItem.rightBarButtonItem  = searchBtnItem
    }

    @objc func searchBtnTapped() {
        presenter.coordinator?.navigateToWeatherVC()
    }

    func addGestureToLbl() {
        let tapSource = UITapGestureRecognizer(target: self, action: #selector(sourceLblAction))
        sourceMainView.addGestureRecognizer(tapSource)

        let tapDestination = UITapGestureRecognizer(target: self, action: #selector(destinationLblAction))
        destinationMainView.addGestureRecognizer(tapDestination)
    }

    @objc func sourceLblAction() {
        sourceTapped = true
        sourceView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.7960784314, blue: 0.537254902, alpha: 1)

        // MARK: - Static Mode
        sourceLocaltion = CLLocationCoordinate2D(latitude: 30.026826, longitude: 31.542354)
        guard let icon = UIImage(named: "car-icon") else {return}
        addMarker(icon: icon, position: sourceLocaltion)
        if destinationTapped == true {
            presenter.didLoad(mapView: mapView)
        }
    }

    @objc func destinationLblAction() {
        destinationTapped = true
        destinationView.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.7960784314, blue: 0.537254902, alpha: 1)
        destinationLocation = CLLocationCoordinate2D(latitude: 30.02573, longitude: 31.49004)
        guard let icon = UIImage(named: "Group 7") else {return}
        addMarker(icon: icon, position: destinationLocation)
        if sourceTapped == true {
            presenter.didLoad(mapView: mapView)
        }
    }

    func setUpMapView() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.settings.myLocationButton = true
        mapView.settings.zoomGestures = true
    }

    func addMarker(icon: UIImage, position: CLLocationCoordinate2D!) {
        let marker = GMSMarker()
        marker.position = position
        marker.icon = icon
        marker.map = mapView
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(marker.position)
        let target = marker.position
        mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 12)
    }
    
    func showMarker(markerList: [GMSMarker]) {
        let target = markerList.first!.position
        mapView.camera = GMSCameraPosition.camera(withTarget: target, zoom: 12)
        var bounds = GMSCoordinateBounds()
        for marker in markerList {
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds)
        mapView.animate(with: update)
    }

}


