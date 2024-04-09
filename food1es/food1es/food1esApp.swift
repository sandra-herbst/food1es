//
//  food1esApp.swift
//  food1es
//
//  Created by Sandra Herbst on 17.05.22.
//

import SwiftUI

@main
struct food1esApp: App {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            // Makes context available to this view and all other child views
            LaunchScreen()
        }
    }
}
