//
//  AddIngredientSheetView.swift
//  food1es
//
//  Created by Sandra Herbst on 28.05.22.
//

import SwiftUI
import Combine

struct AddGrocerySheetView: View {
    
    @StateObject var viewModel: GrocerySheetViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Back & Delete Button + Item name
                buildTopInfo()
                CustomDivider()
                
                // Area to select unit + amount
                UnitSelectionView(selectedUnit: $viewModel.state.selectedUnit, inputAmount: $viewModel.state.inputAmount)
                CustomDivider()
                
                // Area to select aisle from dropdown
                buildAisleDropdown()
                CustomDivider()
                
                // Shows current configuration of the item
                CurrentItemSelection(itemName: $viewModel.state.groceryName, inputAmount: $viewModel.state.inputAmount, displayedAmount: viewModel.state.displayedAmount, selectedAisle: $viewModel.state.selectedAisle)
                buildConfirmButton()
                buildAddToShoppingListButton()
            }
        }
        .background(Color.white)
    }
}

extension AddGrocerySheetView {
    
    func buildTopInfo() -> some View {
        VStack(alignment: .leading) {
            HStack {
                if (viewModel.state.isNewItem) {
                    buildBackButton()
                } else {
                    buildDeleteButton()
                }
                Spacer()
            }
            
            titleText(text: viewModel.state.groceryName)
                .padding([.horizontal, .bottom])
        }
    }
    
    func buildAddToShoppingListButton() -> some View {
        HStack(alignment: .center) {
            Button {
                viewModel.showAddToAlert = true
            } label: {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey("addToAlertTitle"))
                        .font(.system(size: 16))
                    Spacer()
                }
                .foregroundColor(ColorConstants.black)
                .padding()
                .background(ColorConstants.grey)
                .cornerRadius(8)
            }.alert(isPresented: $viewModel.showAddToAlert) {
                Alert(
                    title: Text(LocalizedStringKey("addToAlertTitle")),
                    message: Text(LocalizedStringKey("addToAlertDescription")),
                    primaryButton: .destructive(Text(LocalizedStringKey("addToButton"))) {
                        withAnimation {
                            viewModel.addToShoppingList()
                        }
                    },
                    secondaryButton: .cancel(Text(LocalizedStringKey("cancelButton")))
                )
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    func buildBackButton() -> some View {
        RoundIconButton(iconName: "chevron.backward", backgroundColor: ColorConstants.mainGreen, onPressed: viewModel.resetState)
    }
    
    func buildDeleteButton() -> some View {
        RoundIconButton(iconName: "trash.fill", backgroundColor: ColorConstants.alertRed) {
            viewModel.showDeleteAlert = true
        }
        .alert(isPresented: $viewModel.showDeleteAlert) {
            Alert(
                title: Text(LocalizedStringKey("deleteAlertTitle")),
                message: Text(LocalizedStringKey("deleteAlertDescription")),
                primaryButton: .destructive(Text(LocalizedStringKey("deleteButton"))) {
                    withAnimation {
                        viewModel.deleteGroceryItem()
                        viewModel.showsBottomSheet = false
                    }
                },
                secondaryButton: .cancel(Text(LocalizedStringKey("cancelButton")))
            )
        }
    }
    
    func buildAisleDropdown() -> some View {
        DisclosureGroup(LocalizedStringKey("aisleTitle")) {
            
            ForEach(Aisle.allCases, id: \.rawValue) { aisle in
                VStack(alignment: .leading) {
                    CustomDivider()
                    
                    Button {
                        viewModel.state.selectedAisle = aisle
                    } label: {
                        return Text(aisle.localizedName)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(viewModel.state.selectedAisle == aisle ? ColorConstants.darkGreen : ColorConstants.inactiveColor3)
                    }
                    .padding(8)
                    .background(ColorConstants.inactiveColor2)
                    .cornerRadius(4)
                    
                }
            }
        }
        .accentColor(ColorConstants.mainGreen)
        .font(.system (size: 18, weight: .bold))
        .foregroundColor(ColorConstants.darkGreen)
        .background(Color.white)
        .padding()
    }
    
    func buildConfirmButton() -> some View {
        HStack(alignment: .center) {
            Button {
                if (viewModel.state.isValid()) {
                    viewModel.saveGroceryItem()
                }
            } label: {
                HStack {
                    Spacer()
                    Text(LocalizedStringKey("confirmButtonText"))
                        .font(.system(size: 16))
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background(viewModel.state.isValid() ? ColorConstants.mainGreen : ColorConstants.inactiveColor3)
                .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
}

struct AddGrocerySheetView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddGrocerySheetView(viewModel: GrocerySheetViewModel())
    }
}
