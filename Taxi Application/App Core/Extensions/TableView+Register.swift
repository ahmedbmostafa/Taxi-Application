//
//  TableView+Register.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit

extension UITableView {
    func registerNib(identifier: String) {
         let tableNib = UINib(nibName: identifier, bundle: nil)
         self.register(tableNib, forCellReuseIdentifier: identifier )
     }
}
