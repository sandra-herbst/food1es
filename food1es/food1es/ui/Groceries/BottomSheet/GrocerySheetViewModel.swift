//
//  IngredientSheetViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 28.05.22.
//

import Foundation
import TabularData
import SwiftUI

class GrocerySheetViewModel: ObservableObject {
    
    let shoppingRecipeValue = "Fridge"
    @Published var showsBottomSheet: Bool = false {
        didSet {
            resetState()
        }
    }

    // Add Grocery Sheet
    @Published var showDeleteAlert = false
    @Published var showAddToAlert = false
    @Published var state: GroceryState = GroceryState()
    
    func resetState() {
        state.groceryName = ""
        state.selectedUnit = Units.kilogram
        state.selectedAisle = Aisle.baking
        state.inputAmount = ""
        state.groceryItem = nil
    }
    
    @MainActor
    func saveGroceryItem() {
        do {
            if (state.isNewItem) {
                let item = GroceryItem(context: CoreDataManager.shared.persistentContainer.viewContext)
                item.id = UUID()
                state.groceryItem = item
            }
            
            let item = state.groceryItem
            item?.title = state.groceryName
            item?.unitType = state.selectedUnit
            item?.aisleType = state.selectedAisle
            item?.amount = Double(state.inputAmount) ?? 0
            
            try item?.save()
            showsBottomSheet = false
            print("Item saved... name: \(item?.title ?? "")")
        } catch {
            print("Error in saving: \(error)")
        }
    }
    
    @MainActor
    func deleteGroceryItem() {
        if (!state.isNewItem) {
            do {
                try state.groceryItem?.delete()
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func addToShoppingList() {
        do {
            let item = ShoppingItem(context: CoreDataManager.shared.persistentContainer.viewContext)
            item.id = UUID();
            item.title = state.groceryName
            item.unitType = state.selectedUnit
            item.amount = Double(state.inputAmount) ?? 0
            item.bought = false
            item.recipe = shoppingRecipeValue
        
            try item.save()
            showsBottomSheet = false
            print("Item saved... name: \(item.title ?? "")")
        } catch {
            print("Error in saving: \(error)")
        }
    }
    
    func setNewGroceryToState(suggestion: String) {
        state.groceryName = suggestion
        state.isNewItem = true
    }
    
    func setEditableGroceryToState(item: GroceryItem) {
        state.isNewItem = false
        showsBottomSheet = true
        state.groceryItem = item
        state.groceryName = item.title ?? ""
        state.selectedUnit = item.unitType
        state.selectedAisle = item.aisleType
        state.inputAmount = String(Formatter.getFormattedIngredientMeasurement(amount: item.amount))
    }
}

struct GroceryState {
    
    var groceryName: String = ""
    var selectedUnit: Units = Units.kilogram
    var selectedAisle: Aisle = Aisle.baking
    var inputAmount: String = ""
    
    var isNewItem: Bool = false
    var groceryItem: GroceryItem?
    
    var displayedAmount: String {
        "\(inputAmount) \(selectedUnit.short)"
    }
    
    func isValid() -> Bool {
        return (!groceryName.isEmpty) && (!inputAmount.isEmpty)
    }
}
