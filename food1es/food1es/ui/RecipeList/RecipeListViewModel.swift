//
//  CoreDataViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 18.05.22.
//

import Foundation
import CoreData

class RecipeListViewModel: ObservableObject {
    
    private var context = CoreDataManager.shared.persistentContainer.viewContext
    @Published private(set) var recipes: [RecipeData] = []
    @Published var searchInput: String = ""
    private let service: RecipeService
    
    // Custom Service can be injected for testing
    init(service: RecipeService) {
        self.service = service
    }
    
    @MainActor
    func getRecipies() async -> Void {
        do {
            let response = try await service.fetchRecipeSearch(searchInput: searchInput)
            self.recipes = response.results
            print(recipes)
        } catch {
            print("API Quota has been fully occupied for this day.")
            print(error)
        }
    }
}

