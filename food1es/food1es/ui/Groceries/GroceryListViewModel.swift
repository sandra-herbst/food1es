//
//  IngredientViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 28.05.22.
//

import Foundation
import CoreData
import SwiftUI

@MainActor
class GroceryListViewModel: NSObject, ObservableObject {
    
    @Published var searchInput: String = "" {
        didSet {
            filterGroceries()
        }
    }
    
    @Published var filteredGroceries: [GroceryItem] = []
    @Published var groceries: [GroceryItem] = [] {
        didSet {
            filterGroceries()
        }
    }
    private let fetchedResultsController: NSFetchedResultsController<GroceryItem>
    
    override init() {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: GroceryItem.all, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
    }
    
    func performGroceryItemsFetch() async {
        do {
            try fetchedResultsController.performFetch()
            guard let groceries = fetchedResultsController.fetchedObjects else {
                return
            }
            
            await MainActor.run {
                self.groceries = groceries
                self.filteredGroceries = groceries
                print("Loaded groceries from database... Count: \(groceries.count), filtered: \(filteredGroceries.count)")
            }

        } catch {
            print(error)
        }
    }
    
    func filterGroceries() {
        if (searchInput.isEmpty) {
            self.filteredGroceries = groceries
        } else {
            filteredGroceries = []
            let filtered = groceries.filter({ item in
                item.title!.lowercased().contains(searchInput.lowercased())
            })
            filteredGroceries += filtered
        }
    }
}

extension GroceryListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("Grocery Data changed")
        guard let groceries = controller.fetchedObjects as? [GroceryItem] else {
            return
        }
        
        self.groceries = groceries
    }
}
