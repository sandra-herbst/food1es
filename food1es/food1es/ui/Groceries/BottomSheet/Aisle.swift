//
//  Aisle.swift
//  food1es
//
//  Created by Sandra Herbst on 30.05.22.
//

import Foundation

enum Aisle: Int, CaseIterable, Equatable {
    case baking
    case meat
    case freshProduce
    case spicesSeasonings
    case milkDairy
    case nutJams
    case animalProducts
    
    var localizedName: String {
        switch self {
        case .baking: return "baking".localized
        case .meat: return "meat".localized
        case .freshProduce: return "freshProduce".localized
        case .spicesSeasonings: return "spicesSeasonings".localized
        case .milkDairy: return "milkDairy".localized
        case .nutJams: return "nutJams".localized
        case .animalProducts: return "animalProducts".localized
        }
    }
}
