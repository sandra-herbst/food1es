//
//  Meal.swift
//  food1es
//
//  Created by Sandra Herbst on 25.06.22.
//

import Foundation

enum Meal: String, CaseIterable, Equatable, Decodable {
    case mainCourse = "main course"
    case sideDish = "side dish"
    case lunch = "lunch"
    case dinner = "dinner"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
    case other = "other"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        
        if let mealType = Meal(rawValue: rawString.lowercased()) {
            self = mealType
        } else {
            self = .other
        }
    }
    
    var localizedName: String {
        return self.rawValue.localized
    }
}
