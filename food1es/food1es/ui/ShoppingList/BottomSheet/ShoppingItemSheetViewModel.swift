//
//  ShoppingItemSheetViewModel.swift
//  food1es
//
//  Created by Florian Winkler on 22.06.22.
//

import Foundation
import TabularData
import SwiftUI

class ShoppingItemSheetViewModel: ObservableObject {
    
    @Published var showsBottomSheet: Bool = false {
        didSet {
            resetState()
        }
    }
    
    let shoppingRecipeValue = "Other"
    @Published var showDeleteAlert = false
    @Published var state: ShoppingItemState = ShoppingItemState()
    
    func resetState() {
        state.shoppingItemName = ""
        state.recipe = shoppingRecipeValue
        state.selectedUnit = Units.kilogram
        state.inputAmount = ""
        state.shoppingItem = nil
    }
    
    @MainActor
    func saveShoppingItem() {
        do {
            if (state.isNewItem) {
                let item = ShoppingItem(context: CoreDataManager.shared.persistentContainer.viewContext)
                item.id = UUID()
                state.shoppingItem = item
            }
            
            let item = state.shoppingItem
            item?.title = state.displayedName
            item?.unitType = state.selectedUnit
            item?.amount = Double(state.inputAmount) ?? 0
            item?.recipe = state.recipe
            item?.bought = false
            
            try item?.save()
            showsBottomSheet = false
            print("Item saved... name: \(item?.title ?? "")")
        } catch {
            print("Error in saving: \(error)")
        }
    }
    
    @MainActor
    func updateShoppingItem(item: ShoppingItem) {
        do {
            try item.save()
            print("Item saved... name: \(item.title ?? "")")
        } catch {
            print("Error in saving: \(error)")
        }
    }
    
    func checkItemFromList(item: ShoppingItem) {
        state.bought = true;
        item.bought = state.bought
        print("\(item.title ?? "") was bought")
    }
 
    @MainActor
    func deleteShoppingItem(item: ShoppingItem) {
        do {
            try item.delete()
            print("\(item.title ?? "") was deleted")
        } catch {
            print(error)
        }
    }
    
    func setNewShoppingItemToState(suggestion: String) {
        state.shoppingItemName = suggestion
        state.isNewItem = true
    }
    
    func setEditableShoppingItemToState(item: ShoppingItem) {
        state.isNewItem = false
        showsBottomSheet = true
        state.shoppingItem = item
        state.shoppingItemName = item.title ?? ""
        state.selectedUnit = item.unitType
        state.inputAmount = String(Formatter.getFormattedIngredientMeasurement(amount: item.amount))
        state.recipe = item.recipe ?? shoppingRecipeValue
    }
    
}

struct ShoppingItemState {
    var shoppingItemName: String = ""
    var inputAmount: String = ""
    var selectedUnit: Units = Units.kilogram
    var isNewItem: Bool = false
    var bought: Bool = false
    var shoppingItem: ShoppingItem?
    var recipe: String = ""
    
    var displayedRecipe: String {
        "\(recipe)"
    }
    
    var displayedAmount: String {
        "\(inputAmount) \(selectedUnit.short)"
    }
    
    var displayedName: String {
        "\(shoppingItemName)"
    }
    
    func isValid() -> Bool {
        return (!shoppingItemName.isEmpty) && (!inputAmount.isEmpty)
    }
}
