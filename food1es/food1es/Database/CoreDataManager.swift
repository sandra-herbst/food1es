//
//  RecipeRepository.swift
//  food1es
//
//  Created by Sandra Herbst on 18.05.22.
//

import Foundation
import CoreData

@MainActor
class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    init() {
        persistentContainer = NSPersistentContainer(name: DatabaseConstants.databaseName)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data. \(error)")
            }
        }
    }
}
