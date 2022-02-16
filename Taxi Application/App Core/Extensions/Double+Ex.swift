//
//  Double+Ex.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 15/02/2022.
//

import Foundation

extension Double {
    func removeZerosFromEnd() -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
