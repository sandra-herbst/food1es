//
//  ShoppingItem.swift
//  food1es
//
//  Created by Florian Winkler on 22.06.22.
//

import Foundation
import CoreData

extension ShoppingItem: BaseEntity {
    
    var unitType: Units {
        get {
            return Units(rawValue: Int(unit)) ?? .kilogram
        }
        set {
            unit = Int64(newValue.rawValue)
        }
    }
    
    var displayedAmount: String {
        "\(String(Formatter.getFormattedIngredientMeasurement(amount: amount))) \(unitType.short)"
    }
    
    static var all: NSFetchRequest<ShoppingItem> {
        let request: NSFetchRequest<ShoppingItem> = ShoppingItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return request
    }
}
