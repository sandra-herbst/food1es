//
//  FilterViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 18.06.22.
//

import Foundation
import SwiftUI

class FilterViewModel: ObservableObject {
    @Published var showsBottomSheet = false
    @Published var cuisineChecked: [Bool]
    @Published var mealChecked: [Bool]
    
    init() {
        cuisineChecked = Array(repeating: false, count: Cuisine.allCases.count)
        mealChecked = Array(repeating: false, count: Cuisine.allCases.count)
    }
    
    func getSelectedCuisines() -> [Cuisine] {
        var selectedCuisines: [Cuisine] = []
        for (index, isSelected) in cuisineChecked.enumerated() {
            if (isSelected) {
                selectedCuisines.append(Cuisine.allCases[index])
            }
        }
        return selectedCuisines
    }
    
    func getSelectedMeals() -> [Meal] {
        var selectedMeals: [Meal] = []
        for (index, isSelected) in mealChecked.enumerated() {
            if (isSelected) {
                selectedMeals.append(Meal.allCases[index])
            }
        }
        return selectedMeals
    }
    
    func resetAllFilters() {
        cuisineChecked = Array(repeating: false, count: Cuisine.allCases.count)
        mealChecked = Array(repeating: false, count: Cuisine.allCases.count)
    }
    
    func resetCuisineSelection() {
        cuisineChecked = Array(repeating: false, count: Cuisine.allCases.count)
    }
    
    func resetMealSelection() {
        mealChecked = Array(repeating: false, count: Cuisine.allCases.count)
    }
}
