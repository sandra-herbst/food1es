//
//  TabBarItem.swift
//  food1es
//
//  Created by Sandra Herbst on 24.05.22.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case search, favorites, shopping, ingredients
    
    var iconName: String {
        switch self {
        case .search: return "magnifyingglass"
        case .favorites: return "heart.fill"
        case .shopping: return "bag.fill"
        case .ingredients: return "leaf.fill"
        }
    }
}
