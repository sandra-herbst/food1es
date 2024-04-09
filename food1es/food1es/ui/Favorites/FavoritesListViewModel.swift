//
//  FavoritesViewModel.swift
//  food1es
//
//  Created by Florian Winkler on 27.06.22.
//

import Foundation
import CoreData
import SwiftUI

class FavoritesListViewModel: NSObject, ObservableObject {
    
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    @Published private(set) var recipes: [RecipeData] = []
    @Published var favorites: [Favorite] = []
    let service: RecipeService
    private let fetchedResultsController: NSFetchedResultsController<Favorite>
    
    init(service: RecipeService) {
        self.service = service
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: Favorite.all, managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self
    }
    
    func performFavoritesFetch() async {
        do {
            try fetchedResultsController.performFetch()
            guard let favorites = fetchedResultsController.fetchedObjects else {
                return
            }
            
            await MainActor.run {
                self.favorites = favorites
                print("Loaded favorites from database... Count: \(favorites.count)")
            }
            await fetchFavoriteRecipies()

        } catch {
            print(error)
        }
    }
    
    func fetchFavoriteRecipies() async {
        do {
            for favorite in favorites {
                print("Fetching for id: \(favorite.id)")
                let response = try await service.fetchRecipeInformation(id: Int(favorite.id))
                self.recipes.append(response)
                print("Added recipe to favorites: \(recipes)")
            }
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func addFavoriteRecipe(recipe: RecipeData) {
        do {
            print("Recipe added to favs: \(recipe)")
            recipes.append(recipe)
            let item = Favorite(context: CoreDataManager.shared.persistentContainer.viewContext)
            item.id = Int64(recipe.id);
            item.title = recipe.title
            
            try item.save()
        } catch {
            print(error)
        }
    }
    
    @MainActor
    func removeFavoriteRecipe(recipe: RecipeData) {
        do {
            let item = favorites.first { Favorite in
                Favorite.id == recipe.id
            }
            try item?.delete()
            
            recipes.removeAll { RecipeData in
                RecipeData.id == recipe.id
            }
            print("Recipe removed from favs: \(recipe.title)")
            
        } catch {
            print(error)
        }
    }
}

extension FavoritesListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("Favorites Data changed")
        guard let favorites = controller.fetchedObjects as? [Favorite] else {
            return
        }
        
        self.favorites = favorites
    }
}
