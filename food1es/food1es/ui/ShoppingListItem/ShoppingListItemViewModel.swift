//
//  ShoppingListItemViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import Foundation

@MainActor
class ShoppingListItemViewModel: ObservableObject {
    var item: ShoppingItem
    @Published var bought: Bool {
        didSet {
            updateItem()
        }
    }
    
    init(item: ShoppingItem) {
        self.bought = item.bought
        self.item = item
    }
    
    func updateItem() {
        item.bought = bought
        do {
            try item.save()
            print("Item saved... name: \(item.title ?? "")")
        } catch {
            print("Error in saving: \(error)")
        }
    }
}
