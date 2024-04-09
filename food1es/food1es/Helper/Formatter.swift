//
//  Formatter.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import Foundation

class Formatter {
    static var minIntDigits: Int = 1
    static var minFractionDigits: Int = 0
    static var maxFractionDigits: Int = 2
    
    static func getFormattedIngredientMeasurement(amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minFractionDigits
        formatter.maximumFractionDigits = maxFractionDigits
        formatter.minimumIntegerDigits = minIntDigits
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
