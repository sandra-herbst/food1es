//
//  RecipeCardView.swift
//  food1es
//
//  Created by Sandra Herbst on 22.05.22.
//

import SwiftUI

struct RecipeCardView: View {
    @EnvironmentObject var groceriesViewModel: GroceryListViewModel
    let onFavoriteAdd: (RecipeData) -> Void
    let onFavoriteRemove: (RecipeData) -> Void
    let recipe: RecipeData
    @State var checked: Bool = false
    
    var body: some View {
        NavigationLink(destination: {
            RecipeDetailView(viewModel: RecipeDetailViewModel(recipe: self.recipe, allGroceries: groceriesViewModel.groceries))
        }, label: {
            VStack(alignment: .leading) {
                    ZStack(alignment: .topLeading) {
                        if (recipe.image != nil) {
                            AsyncImage(
                                url: URL(string: recipe.image!), content: { img in
                                    img.resizable()
                                        .aspectRatio(contentMode: .fill)
                                },
                                placeholder: {
                                    ProgressView()
                                        .padding()
                                        .frame(height: 250)
                                }
                            )
                        }
                        
                        Image(systemName: "heart.circle.fill")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(checked ? ColorConstants.darkGreen : ColorConstants.inactiveColor3, .white)
                            .font(.system(size: 32))
                            .padding()
                            .onTapGesture {
                               checked.toggle()
                               checked ? onFavoriteAdd(recipe) : onFavoriteRemove(recipe)
                           }

                    }
                    
                    HStack {
                        titleText(text: recipe.title)
                            .lineLimit(2)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 0.1, trailing: 16))
                
                    VStack {
                        CustomInfoView(text: String(recipe.readyInMinutes) + " min", iconName: "clock.arrow.circlepath")
                    }
                    .padding([.horizontal, .bottom])
                }
                .background(ColorConstants.inactiveColor2)
                .cornerRadius(8)
                .padding(.horizontal)
        })
    }
}
