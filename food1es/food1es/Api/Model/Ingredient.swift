//
//  Ingredient.swift
//  food1es
//
//  Created by Sandra Herbst on 14.06.22.
//

import Foundation

struct Ingredient: Decodable, Identifiable {
    let id: Int
    let name: String
    let measures: Measures
}

struct Measures: Decodable {
    let us: MeasureType
    let metric: MeasureType
}

struct MeasureType: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}
