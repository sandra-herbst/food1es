//
//  CurrentItemSelection.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import SwiftUI

struct CurrentItemSelection: View {
    @Binding var itemName: String
    @Binding var inputAmount: String
    var displayedAmount: String
    var selectedAisle: Binding<Aisle>?
    
    var body: some View {
        VStack(alignment: .leading) {
            subtitleText(locale: LocalizedStringKey("selectionTitle"))
                .bold()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack() {
                    if !inputAmount.isEmpty {
                        subtitleText(text: displayedAmount)
                            .bold()
                        subtitleText(text: " | ")
                    }
                    
                    if selectedAisle != nil {
                        subtitleText(text: selectedAisle!.wrappedValue.localizedName)
                    }
                }
                titleText(text: itemName)
            }
            .padding()
            .background(ColorConstants.inactiveColor)
            .cornerRadius(4)
        }
        .padding()
        .padding(.bottom, 16)
    }
}
