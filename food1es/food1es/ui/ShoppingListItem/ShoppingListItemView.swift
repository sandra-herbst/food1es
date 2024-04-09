//
//  ShoppingListItemView.swift
//  food1es
//
//  Created by Florian Winkler on 06.06.22.
//

import SwiftUI
import Combine

@MainActor
struct ShoppingListItemView: View {
    @StateObject var viewModel: ShoppingListItemViewModel

    var name: String
    var displayedAmount: String
    var onItemPressed: (ShoppingItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(
                columns: [
                    GridItem(.flexible(minimum: 10, maximum: 20)),
                    GridItem(.flexible(minimum: 200, maximum: 200)),
                    GridItem(.flexible(minimum: 60, maximum: 100)),
                ],
                alignment: .leading,
                spacing: 5,
                pinnedViews: [],
                content: {
                    CheckBoxView(checked: $viewModel.bought)
                    
                    Button {
                        onItemPressed(viewModel.item)
                    } label: {
                        subtitleText(text: name).bold()
                            .if(viewModel.bought) { Text in
                                Text.strikethrough()
                            }
                    }
                    
                    subtitleText(text: "\(displayedAmount)")
                        .if(viewModel.bought) { Text in
                            Text.strikethrough()
                        }
                        .lineLimit(2)
                    
                    Spacer()
                    
                })
            .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
        }
        .padding([.top, .horizontal])
    }
}

