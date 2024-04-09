//
//  AppTabBarView.swift
//  food1es
//
//  Created by Sandra Herbst on 24.05.22.
//

import SwiftUI

struct AppTabBarView: View {
    
    @StateObject var groceryViewModel = GroceryListViewModel()
    @StateObject var favoritesListViewModel: FavoritesListViewModel = FavoritesListViewModel(service: RecipeServiceImpl())
    @State private var tabSelection: TabBarItem = .ingredients
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            GroceryListView()
                .tabBarItem(tab: .ingredients, selection: $tabSelection)
                .accessibility(identifier: "groceryTabBar")
            
            RecipeListView()
                .tabBarItem(tab: .search, selection: $tabSelection)
                .accessibility(identifier: "recipeTabBar")
            
            FavoritesListView()
                .tabBarItem(tab: .favorites, selection: $tabSelection)
                .accessibility(identifier: "favoritesTabBar")
            
            ShoppingListView()
                .tabBarItem(tab: .shopping, selection: $tabSelection)
                .accessibility(identifier: "shoppingTabBar")
        }
        .navigationBarHidden(true)
        .environmentObject(favoritesListViewModel)
        .environmentObject(groceryViewModel)
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppTabBarView()
    }
}
