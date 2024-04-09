//
//  StringExtensions.swift
//  food1es
//
//  Created by Sandra Herbst on 31.05.22.
//

import Foundation

extension String {
    
    var localized: String{
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
