//
//  ShoppingListView.swift
//  food1es
//
//  Created by Florian Winkler on 06.06.22.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel: ShoppingListViewModel = ShoppingListViewModel()
    @StateObject private var itemViewModel: ShoppingItemSheetViewModel = ShoppingItemSheetViewModel()
    @StateObject private var suggestionViewModel: SuggestionsViewModel = SuggestionsViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack (alignment: .center) {
                    if (viewModel.shoppingItems.isEmpty) {
                        VStack(alignment: .center) {
                            Image("cart")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 400)
                        }
                        .padding(.top)
                    } else {
                        buildShoppingList()
                    }
                    Spacer()
                }
                .navigationTitle(Text(LocalizedStringKey("navTitleShopping")))
                .floatingActionButton(color: ColorConstants.mainGreen, image: Image(systemName: "plus").foregroundColor(.white), action: {
                    itemViewModel.showsBottomSheet = true
                }).accessibility(identifier: "openAddShoppingItemModal")
            }
            .task {
                await viewModel.performShoppingItemsFetch()
            }
            buildBottomsheet()
        }
    }
    
}

extension ShoppingListView {
    
    func buildShoppingList() -> some View {
        List {
            ForEach(viewModel.shoppingItems) { item in
                ShoppingListItemView(viewModel: ShoppingListItemViewModel(item: item), name: item.title ?? "", displayedAmount: item.displayedAmount, onItemPressed: itemViewModel.setEditableShoppingItemToState)
                    .listRowInsets(EdgeInsets())
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                itemViewModel.deleteShoppingItem(item: item)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }.tint(ColorConstants.alertRed)
                    }
            }
            
        }
        .padding(.top)
        .listStyle(.plain)
    }
    
    func buildBottomsheet() -> some View {
        GeometryReader { geometry in
            itemViewModel.showsBottomSheet ? ColorConstants.black.opacity(0.6) : nil
            CustomBottomSheetView(
                isOpen: $itemViewModel.showsBottomSheet,
                maxHeight: geometry.size.height * 0.9
            ) {
                if (itemViewModel.state.shoppingItem == nil && itemViewModel.state.shoppingItemName.isEmpty) {
                    SuggestionsView(viewModel: suggestionViewModel, onSuggestionPressed: itemViewModel.setNewShoppingItemToState)
                    
                } else {
                    ShoppingItemSheetView(viewModel: itemViewModel)
                        .if(itemViewModel.state.isNewItem) { $0.transition(.move(edge: .trailing)) }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


struct ShoppingItemSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemSheetView(viewModel: ShoppingItemSheetViewModel())
    }
}
