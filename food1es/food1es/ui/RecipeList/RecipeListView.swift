//
//  CoreDataSampleView.swift
//  food1es
//
//  Created by Sandra Herbst on 18.05.22.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var favoritesViewModel: FavoritesListViewModel
    @StateObject private var viewModel: RecipeListViewModel = RecipeListViewModel(
        service: RecipeServiceImpl()
    )
    @StateObject private var sheetViewModel: FilterViewModel = FilterViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    buildTopSearch()
                }
                .navigationTitle(LocalizedStringKey("navTitleRecipeSearch"))
                .navigationBarTitleTextColor(ColorConstants.darkGreen)
            }
            
            buildBottomsheet()
        }
    }
}

extension RecipeListView {
    
    func buildTopSearch() -> some View {
        VStack (alignment: .center) {
            CustomTextFieldView(text: $viewModel.searchInput, promptText: LocalizedStringKey("searchRecipeTextPrompt"),
                                onSubmit: { await viewModel.getRecipies() })
                .padding(.horizontal)
                .accessibility(identifier: "searchRecipeText")
            
            HStack {
                Button {
                    sheetViewModel.showsBottomSheet = true
                } label: {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                        
                        Text("filter".localized)
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .padding(.horizontal)
                    .background(ColorConstants.mainGreen)
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                Spacer()
            }
            
            buildResultList()
        }
    }
    
    func buildResultList() -> some View {
        VStack {
            CustomDivider()
                .padding(.top)
            let filteredRecipes = FilterSortHelper.filterRecipeList(recipes: viewModel.recipes, selectedCuisines: sheetViewModel.getSelectedCuisines(), selectedMealTypes: sheetViewModel.getSelectedMeals())
            
            // Only show number of results if there are any
            if (filteredRecipes.count != 0) {
                inactiveText(text: String(format: NSLocalizedString("amountResults", comment: ""), "\(filteredRecipes.count)"), size: 18)
                    .padding(.vertical, 8)
            }
            
            ForEach(filteredRecipes) { recipe in
                RecipeCardView(onFavoriteAdd: favoritesViewModel.addFavoriteRecipe, onFavoriteRemove:  favoritesViewModel.removeFavoriteRecipe, recipe: recipe)
                    .padding(.bottom)
            }
        }
    }
    
    func buildBottomsheet() -> some View {
        GeometryReader { geometry in
            sheetViewModel.showsBottomSheet ? ColorConstants.darkGreen.opacity(0.6) : nil
            CustomBottomSheetView(
                isOpen: $sheetViewModel.showsBottomSheet,
                maxHeight: geometry.size.height * 0.9
            ) {
                FilterView(viewModel: sheetViewModel)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct CoreDataSampleView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
