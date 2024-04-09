//
//  Favorite.swift
//  food1es
//
//  Created by Sandra Herbst on 01.07.22.
//

import Foundation
import CoreData

extension Favorite: BaseEntity {
    static var all: NSFetchRequest<Favorite> {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return request
    }
}
