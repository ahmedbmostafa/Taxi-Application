//
//  WeatherTableViewCell.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureDateLbl: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var windDegreeLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.contentView.layer.cornerRadius = 8
    }

    func updateUI(data: ListModel) {
        let iconUrl = APIConstants.ImageBaseURL + (data.weather?.first?.icon ?? "") + ".png"
        if let url = URL(string: iconUrl) {
            weatherIcon.kf.setImage(with: url)
        }
        temperatureDateLbl.text = data.dt?.convertDate()
        temperatureLbl.text = (data.main?.temp?.removeZerosFromEnd() ?? "") + "°"
        descriptionLbl.text = data.weather?.first?.weather_description ?? ""
        windDegreeLbl.text = (data.wind?.deg?.removeZerosFromEnd() ?? "")
        windSpeedLbl.text = (data.wind?.speed?.removeZerosFromEnd() ?? "") + "km/h"
        humidityLbl.text = (data.main?.humidity?.removeZerosFromEnd() ?? "") + "%"
    }
    
}
