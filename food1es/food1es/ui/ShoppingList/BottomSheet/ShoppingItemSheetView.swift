//
//  ShoppingItemSheetView.swift
//  food1es
//
//  Created by Florian Winkler on 22.06.22.
//

import SwiftUI
import Combine

struct ShoppingItemSheetView: View {
    
    @StateObject var viewModel: ShoppingItemSheetViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                buildTopInfo()
                CustomDivider()
                UnitSelectionView(selectedUnit: $viewModel.state.selectedUnit, inputAmount: $viewModel.state.inputAmount)
                CustomDivider()
                CurrentItemSelection(itemName: $viewModel.state.shoppingItemName, inputAmount: $viewModel.state.inputAmount, displayedAmount: viewModel.state.displayedAmount)
                buildConfirmButton()
                
            }
        }
        .background(Color.white)
    }
    
}

extension ShoppingItemSheetView {
    
    func buildTopInfo() -> some View {
        VStack(alignment: .leading) {
            if (viewModel.state.isNewItem) {
                buildBackButton()
            }
            titleText(text: viewModel.state.shoppingItemName)
                .padding()
        }
    }
    
    func buildBackButton() -> some View {
        RoundIconButton(iconName: "chevron.backward", backgroundColor: ColorConstants.mainGreen, onPressed: viewModel.resetState)
    }
    
    func buildConfirmButton() -> some View {
        HStack(alignment: .center) {
            Button {
                if (viewModel.state.isValid()) {
                    viewModel.saveShoppingItem()
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
                .background(viewModel.state.isValid() ? ColorConstants.mainGreen : ColorConstants.inactiveColor2)
                .cornerRadius(8)
            }
        }
        .padding([.horizontal, .bottom])
    }
}
