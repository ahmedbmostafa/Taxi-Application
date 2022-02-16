//
//  WeatherVC.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit
import Kingfisher

protocol FetchWeatherProtocol: class {
    func fetchWeather(weather: WeatherModelResponse)
    func showActivityIndicator(show: Bool)
    func showError(error : Error)
}

class WeatherVC: UIViewController, FetchWeatherProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var presenter : WeatherPresenterProtocol!
    var weatherList = [ListModel]()
    var activityIndicator: ActivityIndicatorStates!
    let refreshControl = UIRefreshControl()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.0862745098, green: 0.5647058824, blue: 0.6901960784, alpha: 1)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = ActivityIndicator()
        setSearchController()
        setUpTableView()
    }

    func setSearchController() {
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        definesPresentationContext = true
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.systemFont(ofSize: 12)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.systemFont(ofSize: 12)
        searchBar.backgroundImage = UIImage()
    }

    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(identifier: "WeatherTableViewCell")
        refreshControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func refreshTableData() {
        presenter.didLoad()
        checkConnection(isError: false)
    }
    
    func checkConnection(isError: Bool) {
        if !Connectivity.isConnectedToInternet {
            if isError {
                view.makeToast("Check internet connection")
            } else {
                if weatherList.count > 0 {
                    view.makeToast("Not accurate data..")
                } else {
                    view.makeToast("Check internet connection")
                }
            }
        }
    }
}
