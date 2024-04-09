//
//  FilterSortHelper.swift
//  food1es
//
//  Created by Sandra Herbst on 05.06.22.
//

import Foundation

class FilterSortHelper {
    
    static func filterStringList(searchInput: String, allStrings: [String]) -> [String] {
        if (searchInput.isEmpty) {
            return allStrings
        } else {
            var filteredStrings: [String] = []
            filteredStrings.append(searchInput)
            let filtered = allStrings.filter({ item in
                item.lowercased().contains(searchInput.lowercased())
            })
            filteredStrings += filtered
            return filteredStrings
        }
    }
    
    
    static func filterRecipeList(recipes: [RecipeData], selectedCuisines: [Cuisine], selectedMealTypes: [Meal]) -> [RecipeData] {
        var filteredRecipes: [RecipeData] = []
        
        // no filter selected
        if (selectedCuisines.isEmpty && selectedMealTypes.isEmpty) {
            return recipes
        }
        
        filteredRecipes = recipes.filter { RecipeData in
            // if no filter, then its true automatically (every recipe can be shown)
            let hasSelectedCuisine = selectedCuisines.isEmpty ? true : Set(selectedCuisines).isSubset(of: Set(RecipeData.cuisines))
            let hasSelectedMealType = selectedMealTypes.isEmpty ? true : Set(selectedMealTypes).isSubset(of: Set(RecipeData.dishTypes))
            return hasSelectedCuisine && hasSelectedMealType
        }

        return filteredRecipes
    }
}
