//
//  IngredientListItem.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import SwiftUI

struct IngredientListItem: View {
    let onAdd: (String, String, Double) -> Void
    var name: String
    var unitLong: String
    var unitShort: String
    var portionMeasurement: Double
    var isMissingIngredient: Bool
    @State var isAdded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomDivider().opacity(0.5)
            HStack {
                subtitleText(text: name.capitalizingFirstLetter())
                    .if(isMissingIngredient) { Text in
                        Text.bold()
                    }
                Spacer()
            
                inactiveText(text: String(Formatter.getFormattedIngredientMeasurement(amount: portionMeasurement)) + " " + unitLong.capitalizingFirstLetter())
                    .padding(.horizontal)
                
                Button {
                    if !isAdded {
                        onAdd(name, unitShort, portionMeasurement)
                        isAdded = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(isAdded ? ColorConstants.inactiveColor3 : ColorConstants.mainGreen)
                        .clipShape(Circle())
                }
            }
        }
        .padding()
    }
}

struct IngredientListItem_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListItem(onAdd: { name, unit, portion in }, name: "Ingredient", unitLong: "Liter", unitShort: "g", portionMeasurement: 5.0, isMissingIngredient: true)
    }
}
