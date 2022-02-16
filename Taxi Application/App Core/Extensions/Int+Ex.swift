//
//  Int+Ex.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 14/02/2022.
//

import Foundation

extension Int {
    func convertDate() -> String{
        let timeInterval = TimeInterval(self)
        let myDate = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en")
        let dateString = dateFormatter.string(from: myDate)
        let convertedDate = dateFormatter.date(from: dateString)
        guard dateFormatter.date(from: dateString) != nil else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
    }
}
