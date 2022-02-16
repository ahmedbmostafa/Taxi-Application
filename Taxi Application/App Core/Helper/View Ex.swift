//
//  View Ex.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import UIKit

class RoundView: UIView {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  self.frame.height / 2
    }
}

class RoundViewBorder: UIView {
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius =  8
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    }
}
