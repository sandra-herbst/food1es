//
//  RecipeDetailViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 14.06.22.
//

import Foundation
import SwiftUI

@MainActor
class RecipeDetailViewModel: ObservableObject {
    
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    var recipe: RecipeData
    var allGroceries: [GroceryItem]
    var ownedIngredientsList: [Ingredient] = []
    var missedIngredientsList: [Ingredient] = []
    
    var maxPortions: Int = 30
    var minPortions: Int = 1
    @Published var portions: Int
    
    init(recipe: RecipeData, allGroceries: [GroceryItem]) {
        self.recipe = recipe
        self.portions = recipe.servings
        self.allGroceries = allGroceries
        ownedIngredientsList = getIngredientList(isMissing: false)
        missedIngredientsList = getIngredientList(isMissing: true)
    }
    
    func increasePortions() {
        if (portions == maxPortions) { return }
        portions += 1
    }
    
    func decreasePortions() {
        if (portions == minPortions) { return }
        portions -= 1
    }
    
    private func getIngredientList(isMissing: Bool) -> [Ingredient] {
        var list: [Ingredient] = []
        
        for Ingredient in recipe.extendedIngredients {
            let hasGrocery: Bool = self.allGroceries.contains { GroceryItem in
                let name1 = GroceryItem.title?.lowercased()
                let name2 = Ingredient.name.lowercased()

                // Items you own have equal strings
                return name1 == name2
            }
            if (hasGrocery && !isMissing) {
                list.append(Ingredient)
            } else if (!hasGrocery && isMissing) {
                list.append(Ingredient)
            }
        }
        return list
    }
    
    func addIngredientToShopping(name: String, unit: String, portion: Double) {
        do {
            var unitType: Units = Units.count
            
            for unitEnum in Units.allCases {
                if (unitEnum.short == unit) {
                    unitType = unitEnum
                    break
                }
            }
            
            let item = ShoppingItem(context: CoreDataManager.shared.persistentContainer.viewContext)
            item.id = UUID()
            item.title = name.capitalizingFirstLetter()
            item.unitType = unitType
            item.amount = portion
            item.recipe = recipe.title
            item.bought = false
            
            try item.save()
        } catch {
            print(error)
        }
    }
}
