//
//  CurrentInpout.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import SwiftUI
import Combine

struct UnitSelectionView: View {
    @Binding var selectedUnit: Units
    @Binding var inputAmount: String
    
    var body: some View {
        VStack(alignment: .leading) {
            buildUnitTypes()
            buildAmountInput()
        }
    }
}

extension UnitSelectionView {
    
    func buildUnitTypes() -> some View {
        VStack(alignment: .leading) {
            subtitleText(locale: LocalizedStringKey("unitTypeTitle"))
                .bold()
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()), GridItem(.flexible())
                ],
                alignment: .leading,
                spacing: 5,
                pinnedViews: [],
                content: {
                    ForEach (Units.allCases, id: \.rawValue) { unit in
                        CustomListElementButtonView(text: unit.long, color: selectedUnit == unit ? ColorConstants.mainGreen : ColorConstants.inactiveColor3, minWidth: 150) {
                            selectedUnit = unit
                        }
                    }
                })
        }
        .padding()
    }
    
    func buildAmountInput() -> some View {
        VStack(alignment: .leading) {
            HStack {
                CustomTextFieldView(text: $inputAmount, promptText: LocalizedStringKey("amountTextPrompt"))
                    .keyboardType(.numberPad)
                    .onReceive(Just(inputAmount)) { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        if filtered != newValue {
                            inputAmount = filtered
                        }
                    }
                
                if (selectedUnit != Units.count) {
                    CustomListElementView(text: selectedUnit.short, color: ColorConstants.mainGreen)
                }
            }
        }
        .padding([.horizontal, .bottom])
    }
}

struct CurrentInputView_Previews: PreviewProvider {
    struct CurrentInputViewHolder: View {
        @State var selectedUnit: Units = Units.kilogram
        @State var inputAmount: String = ""
        
        var body: some View {
            UnitSelectionView(selectedUnit: $selectedUnit, inputAmount: $inputAmount)
        }
    }
    
    static var previews: some View {
        CurrentInputViewHolder()
    }
}
