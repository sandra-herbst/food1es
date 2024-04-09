//
//  WelcomeScreenViewModel.swift
//  food1es
//
//  Created by Matthias Stöppler on 27.06.22.
//

import Foundation
import CoreData
import SwiftUI

class WelcomeScreenViewModel:NSObject, ObservableObject  {
    
    @Published var nameInput: String = ""
    let defaults = UserDefaults.standard
    
    func saveUserName() {
        defaults.set(nameInput, forKey: AppConstants.username_KEY)
    }

    func isValidName() -> Bool {
        return nameInput.count > 0 && nameInput.count < 20
    }
}
