//
//  CheckConnection.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
