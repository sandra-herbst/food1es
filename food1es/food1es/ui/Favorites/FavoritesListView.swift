//
//  FavoritesView.swift
//  food1es
//
//  Created by Florian Winkler on 27.06.22.
//

import SwiftUI

struct FavoritesListView: View {
    
    @EnvironmentObject private var viewModel: FavoritesListViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack (alignment: .center) {
                    
                    if (viewModel.recipes.isEmpty) {
                        VStack(alignment: .center) {
                            Text(LocalizedStringKey("favoritesEmptyText"))
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(ColorConstants.darkGreen)
                        }
                        .padding(.top)
                        .frame(width: 300, alignment: .center)
                        
                    } else {
                        ScrollView {
                            buildFavoritesList()
                        }
                    }
                }
                .navigationTitle(LocalizedStringKey("navTitleFavorites"))
                .navigationBarTitleTextColor(ColorConstants.darkGreen)
            }
        }
        .task {
            await viewModel.performFavoritesFetch()
        }
    }
}

extension FavoritesListView {
    func buildFavoritesList() -> some View {
        VStack(alignment: .center) {
            CustomDivider()
                .padding(.top)
            
            ForEach(viewModel.recipes) { recipe in
                RecipeCardView(onFavoriteAdd: {_ in}, onFavoriteRemove: viewModel.removeFavoriteRecipe, recipe: recipe, checked: true)
                    .padding(.bottom)
            }
        }
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
        
    }
}
