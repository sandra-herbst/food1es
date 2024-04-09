//
//  AddIngredientSheetView.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

struct SuggestionsView: View {
    
    @StateObject var viewModel: SuggestionsViewModel
    var onSuggestionPressed: (_ suggestion: String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            titleText(locale: LocalizedStringKey("searchGrocerySheetTitle"))
                .padding([.horizontal, .top])
            
            VStack(alignment: .leading) {
                CustomTextFieldView(text: $viewModel.searchInput, promptText: LocalizedStringKey("searchGroceryTextPrompt"))
            }
            .padding(.horizontal)
            
            CustomDivider()
            
            VStack(alignment: .leading, spacing: 12) {
                subtitleText(locale: LocalizedStringKey("suggestionListTitle"))
                    .bold()
                CustomDivider()
                
                List {
                    ForEach(viewModel.suggestions, id: \.self) { suggestion in
                        VStack(alignment: .leading) {
                            Button {
                                withAnimation {
                                    //viewModel.setNewGroceryToState(suggestion: suggestion)
                                    onSuggestionPressed(suggestion)
                                }
                            } label: {
                                Text(suggestion)
                                    .foregroundColor(suggestion == viewModel.suggestions.first && !viewModel.searchInput.isEmpty ? ColorConstants.inactiveColor3 : ColorConstants.darkGreen)
                            }
                            
                            CustomDivider()
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
            }
            .padding(.horizontal)
        }
        .background(Color.white)
    }
}

struct SearchGrocerySheetView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView(viewModel: SuggestionsViewModel()) { suggestion in
            print("Suggestion pressed \(suggestion)")
        }
    }
}
