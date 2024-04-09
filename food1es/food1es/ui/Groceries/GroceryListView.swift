//
//  IngredientSearchView.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

struct GroceryListView: View {
    
    @EnvironmentObject private var viewModel: GroceryListViewModel
    @StateObject private var sheetViewModel: GrocerySheetViewModel = GrocerySheetViewModel()
    @StateObject private var suggestionViewModel: SuggestionsViewModel = SuggestionsViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    CustomTextFieldView(text: $viewModel.searchInput, promptText: LocalizedStringKey("searchGroceryTextPrompt"))
                        .padding(.horizontal)
                    
                    CustomDivider()
                        .padding(.vertical)
                    
                    if (viewModel.groceries.isEmpty) {
                        VStack(alignment: .center) {
                            Image("fridge")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                        }
                        .padding(.top)
                        
                    } else {
                        buildGroceryList()
                    }
                    Spacer()
                }
                .navigationTitle(Text(LocalizedStringKey("navTitleGroceries")))
                .navigationBarTitleTextColor(ColorConstants.darkGreen)
                .floatingActionButton(color: ColorConstants.mainGreen, image: Image(systemName: "plus").foregroundColor(.white), action: {
                    sheetViewModel.showsBottomSheet.toggle()
                })
            }
            .task {
                await viewModel.performGroceryItemsFetch()
            }
            
            buildBottomsheet()
        }
    }
}

extension GroceryListView {
    
    func buildGroceryList() -> some View {
        List(Aisle.allCases, id: \.rawValue) { aisle in
            let aisleGroceries = viewModel.filteredGroceries.filter { item in
                item.aisleType == aisle
            }
            
            if aisleGroceries.count != 0 {
                Section(header: subtitleText(text: aisle.localizedName).bold()) {
                    ForEach(aisleGroceries) { item in
                        Button {
                            sheetViewModel.setEditableGroceryToState(item: item)
                        } label: {
                            CustomListElementView(text: "\(item.displayedAmount) \(item.title ?? "")", color: ColorConstants.mainGreen)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                        .listRowSeparator(.hidden)
                    }
                }
                .listRowInsets(EdgeInsets())
                .accentColor(ColorConstants.mainGreen)
            }
        }
        .padding([.bottom])
    }
    
    func buildBottomsheet() -> some View {
        GeometryReader { geometry in
            sheetViewModel.showsBottomSheet ? ColorConstants.black.opacity(0.6) : nil
            CustomBottomSheetView(
                isOpen: $sheetViewModel.showsBottomSheet,
                maxHeight: geometry.size.height * 0.9
            ) {
                if (sheetViewModel.state.groceryItem == nil && sheetViewModel.state.groceryName.isEmpty) {
                    SuggestionsView(viewModel: suggestionViewModel, onSuggestionPressed: sheetViewModel.setNewGroceryToState)
                } else {
                    AddGrocerySheetView(viewModel: sheetViewModel)
                        .if(sheetViewModel.state.isNewItem) { $0.transition(.move(edge: .trailing)) }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
