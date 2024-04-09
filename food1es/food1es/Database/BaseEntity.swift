//
//  EntityProtocol.swift
//  food1es
//
//  Created by Sandra Herbst on 18.05.22.
//

import Foundation
import CoreData

// Defines extension methods on entity objects, so after creating an Entity,
// it will be able to save/delete itself.
protocol BaseEntity {
    static var viewContext: NSManagedObjectContext { get }
    func save() throws
    func delete() throws
}

extension BaseEntity where Self: NSManagedObject {
    static var viewContext: NSManagedObjectContext {
        CoreDataManager.shared.persistentContainer.viewContext
    }
    
    func save() throws {
        try Self.viewContext.save()
    }
    
    func delete() throws {
        Self.viewContext.delete(self)
        try save()
    }
}
