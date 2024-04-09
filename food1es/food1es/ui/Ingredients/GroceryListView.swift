//
//  IngredientSearchView.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

struct GroceryListView: View {
    
    @StateObject private var viewModel: GroceryListViewModel = GroceryListViewModel()
    @StateObject private var itemViewModel: GrocerySheetViewModel = GrocerySheetViewModel()
    @StateObject private var suggestionViewModel: SuggestionsViewModel = SuggestionsViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        CustomTextFieldView(text: $viewModel.searchInput, promptText: LocalizedStringKey("searchGroceryTextPrompt"))
                            .padding([.bottom, .horizontal, .top])
                        
                        CustomDivider()
                            .padding(.bottom)
                        
                        List(Aisle.allCases, id: \.rawValue) { aisle in
                            let aisleGroceries = viewModel.filteredGroceries.filter { item in
                                item.aisleType == aisle
                            }
                            
                            if aisleGroceries.count != 0 {
                                Section(header: subtitleText(text: aisle.localizedName).bold()) {
                                    ForEach(aisleGroceries) { item in
                                        Button {
                                            itemViewModel.setEditableGroceryToState(item: item)
                                        } label: {
                                            CustomListElementView(text: "\(item.displayedAmount)  |  \(item.title ?? "")", color: ColorConstants.mainGreen)
                                        }
                                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                                        .listRowSeparator(.hidden)
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                                .accentColor(ColorConstants.mainGreen)
                            }
                        }
                        .padding([.bottom, .horizontal])
                    }
                    
                    Spacer()
                }
                .navigationTitle(Text(LocalizedStringKey("navTitleGroceries")))
                .navigationBarTitleTextColor(ColorConstants.darkGreen)
                .floatingActionButton(color: ColorConstants.mainGreen, image: Image(systemName: "plus").foregroundColor(.white), action: {
                    itemViewModel.showsBottomSheet = true
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
    
    func buildBottomsheet() -> some View {
        GeometryReader { geometry in
            itemViewModel.showsBottomSheet ? ColorConstants.black.opacity(0.6) : nil
            CustomBottomSheetView(
                isOpen: $itemViewModel.showsBottomSheet,
                maxHeight: geometry.size.height * 0.9
            ) {
                // If groceryItem is nil, no grocery has been selected from the list
                // If groceryName is Empty, no suggestion has been selected
                if (itemViewModel.state.groceryItem == nil && itemViewModel.state.groceryName.isEmpty) {
                    SuggestionsView(viewModel: suggestionViewModel, onSuggestionPressed: itemViewModel.setNewGroceryToState)

                } else {
                    AddGrocerySheetView(viewModel: itemViewModel)
                        .if(itemViewModel.state.isNewItem) { $0.transition(.move(edge: .trailing)) }
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
