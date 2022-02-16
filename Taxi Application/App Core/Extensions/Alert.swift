//
//  Alert.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import UIKit

extension UIAlertController {

    @discardableResult
    static func showAlert(withMessage  message: String) -> UIAlertController{
        let controller = UIAlertController(title: nil,
                                           message: message,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        controller.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        return controller
    }
}
