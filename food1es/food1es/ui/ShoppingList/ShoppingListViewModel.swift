//
//  ShoppingListViewModel.swift
//  food1es
//
//  Created by Florian Winkler on 06.06.22.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class ShoppingListViewModel: NSObject, ObservableObject {
    
    @Published var shoppingItems: [ShoppingItem] = []
    @Published var availableRecipes: [String] = [] {
        didSet {
//            getAvailableRecipes()
        }
    }
    
    private let fetchedResultsController: NSFetchedResultsController<ShoppingItem>
    
    override init() {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: ShoppingItem.all, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
    }
    
    func performShoppingItemsFetch() async {
        do {
            try fetchedResultsController.performFetch()
            guard let shoppingItems = fetchedResultsController.fetchedObjects else {
                return
            }
            
            await MainActor.run {
                self.shoppingItems = shoppingItems
                print("Loaded shopping items from database... Count: \(shoppingItems.count)")
            }

        } catch {
            print(error)
        }
    }
    
//    func getAvailableRecipes() {
//
//        availableRecipes = []
//        let allRecipes = shoppingItems.map({ item in
//            item.recipe
//        })
//        print("All recipes: \(allRecipes)")
//        let filteredRecipes = allRecipes.map({ item in
//            if !availableRecipes.contains(item) {
//                availableRecipes += item
//            }
//        })
//
//    }

}

extension ShoppingListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("Controller: Shopping Data changed")
        guard let shoppingItems = controller.fetchedObjects as? [ShoppingItem] else {
            return
        }
        
        self.shoppingItems = shoppingItems
    }
}
