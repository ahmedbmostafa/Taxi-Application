//
//  WeatherVC+Ex.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit

extension WeatherVC {

    func fetchWeather(weather: WeatherModelResponse) {
        guard let list = weather.list else {
            weatherList = []
            tableView.reloadData()
            UIAlertController.showAlert(withMessage: weather.cod ?? "")
            return}
        self.weatherList = list
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        view.endEditing(true)
    }

    func showActivityIndicator(show: Bool) {
        show ? self.activityIndicator.startAnimating(viewController: self) : self.activityIndicator.stopAnimating()
    }

    func showError(error: Error) {
        weatherList = []
        tableView.reloadData()
        checkConnection(isError: true)
        UIAlertController.showAlert(withMessage: error.localizedDescription)

    }
}

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        let data = weatherList[indexPath.row]
        cell.updateUI(data: data)
        return cell
    }
}

extension WeatherVC: UISearchBarDelegate  {

    func searchBarIsEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cityName = searchBar.text?.lowercased()
        presenter.didLoad()
        checkConnection(isError: false)
    }
}
