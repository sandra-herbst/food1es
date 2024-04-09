//
//  Unit.swift
//  food1es
//
//  Created by Sandra Herbst on 28.05.22.
//

import Foundation
import SwiftUI

enum Units: Int, CaseIterable, Equatable {
    case kilogram
    case gram
    case liter
    case milliliter
    case count
    
    var long: String {
        return String(format: NSLocalizedString("unitTitleFormatted", comment: ""), "\(self.localizedName)", "\(self.short)")
    }
    
    var localizedName: String {
        switch self {
        case .kilogram: return "kilogram".localized
        case .gram: return "gram".localized
        case .liter: return "liter".localized
        case .milliliter: return "milliliter".localized
        case .count: return "count".localized
        }
    }
    
    var short: String {
        switch self {
        case .kilogram: return "kg"
        case .gram: return "g"
        case .liter: return "L"
        case .milliliter: return "ml"
        case .count: return "x"
        }
    }
}
