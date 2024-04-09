//
//  RecipeRepository.swift
//  food1es
//
//  Created by Sandra Herbst on 18.05.22.
//

import Foundation
import SwiftUI

struct RecipeResult: Decodable {
    let number: Int
    let totalResults: Int
    let results: [RecipeData]
}

// Recipe is saved into core data whenever a user marks it as a favorite.
// The data is retrieved from the API.
struct RecipeData: Decodable, Identifiable {
    let id: Int
    let title: String
    var image: String?
    let servings: Int
    let readyInMinutes: Int
    let aggregateLikes: Int
    let pricePerServing: Double
    let summary: String
    let cuisines: [Cuisine]
    let dishTypes: [Meal]
    let extendedIngredients: [Ingredient]
    let analyzedInstructions: [RecipeInstruction]
}
