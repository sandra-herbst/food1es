//
//  GroceryItem.swift
//  food1es
//
//  Created by Sandra Herbst on 04.06.22.
//

import Foundation
import CoreData

extension GroceryItem: BaseEntity {
    
    var unitType: Units {
        get {
            return Units(rawValue: Int(unit)) ?? .kilogram
        }
        set {
            unit = Int64(newValue.rawValue)
        }
    }
    
    var aisleType: Aisle {
        get {
            return Aisle(rawValue: Int(aisle)) ?? .freshProduce
        }
        set {
            aisle = Int64(newValue.rawValue)
        }
    }
    
    var displayedAmount: String {
        "\(String(Formatter.getFormattedIngredientMeasurement(amount: amount))) \(unitType.short)"
    }
    
    static var all: NSFetchRequest<GroceryItem> {
        let request: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return request
    }
}
