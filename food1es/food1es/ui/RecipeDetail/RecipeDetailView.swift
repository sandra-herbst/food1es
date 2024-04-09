//
//  RecipeDetailView.swift
//  food1es
//
//  Created by Sandra Herbst on 22.05.22.
//

import SwiftUI

struct RecipeDetailView: View {
    
    @StateObject var viewModel: RecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                topImage
                
                VStack(alignment: .leading, spacing: 10) {
                    topInfoView
                    titleText(text: viewModel.recipe.title)
                        .padding(.horizontal)
                    
                    portionSettingsView
                    CustomDivider()
                    ingredientsView
                    CustomDivider()
                    instructionSteps
                    
                    Spacer()
                }
            }
        }
    }
}

extension RecipeDetailView {
    
    var topImage: some View {
        AsyncImage(
            url: URL(string: viewModel.recipe.image ?? ""), content: { img in
                img.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
            },
            placeholder: {
                ProgressView()
                    .padding()
                    .frame(height: 250)
            }
        )
        .cornerRadius(8, corners: [.topLeft, .topRight])
        .frame(height: 250)
        .padding(.bottom)
    }
    
    var topInfoView: some View {
        HStack(spacing: 20) {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 16))
                    .foregroundColor(ColorConstants.inactiveColor3)
                
                inactiveText(text: String(viewModel.recipe.readyInMinutes) + " min")
                    .font(.system(size: 12))
            }
            HStack {
                Image(systemName: "heart")
                    .font(.system(size: 16))
                    .foregroundColor(ColorConstants.inactiveColor3)
                
                inactiveText(text: String(viewModel.recipe.aggregateLikes))
                    .font(.system(size: 12))
            }
        }
        .padding(.horizontal)
    }
    
    var portionSettingsView: some View {
        HStack(spacing: 30) {
            subtitleText(locale: LocalizedStringKey("portions"))
                .bold()
            
            Spacer()
            
            Button {
                viewModel.decreasePortions()
            } label: {
                Image(systemName: "minus")
                    .foregroundColor(ColorConstants.mainGreen)
                    .padding(20)
                    .frame(width: 50, height: 50)
                    .background(.gray.opacity(0.4))
                    .clipShape(Circle())
            }
            
            titleText(text: String(viewModel.portions))
            
            Button {
                viewModel.increasePortions()
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(ColorConstants.mainGreen)
                    .padding(20)
                    .frame(width: 50, height: 50)
                    .background(.gray.opacity(0.4))
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
        .padding(.top, 20)
        .padding(.bottom, 8)
    }
    
    var ingredientsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(locale: LocalizedStringKey("ingredients"))
                .padding(.bottom)
            
            ForEach(viewModel.ownedIngredientsList) { ingredient in
                let portionMeasurement = (round(ingredient.measures.metric.amount) / Double(viewModel.recipe.servings)) * Double(viewModel.portions)
                IngredientListItem(onAdd: { name, unit, portion in}, name: ingredient.name, unitLong: ingredient.measures.metric.unitLong, unitShort: ingredient.measures.metric.unitShort, portionMeasurement: portionMeasurement, isMissingIngredient: false)
            }
            
            ForEach(viewModel.missedIngredientsList) { ingredient in
                let portionMeasurement = (round(ingredient.measures.metric.amount) / Double(viewModel.recipe.servings)) * Double(viewModel.portions)
                IngredientListItem(onAdd: viewModel.addIngredientToShopping, name: ingredient.name, unitLong: ingredient.measures.metric.unitLong, unitShort: ingredient.measures.metric.unitShort, portionMeasurement: portionMeasurement, isMissingIngredient: true)
            }
        }
        .padding()
    }
    
    var instructionSteps: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText(locale: LocalizedStringKey("preparations"))
                .padding(.bottom)
            
            
            ForEach(viewModel.recipe.analyzedInstructions) { instructionPart in
                let hasTitle = !instructionPart.name.isEmpty
                
                if hasTitle {
                    subtitleText(text: instructionPart.name)
                        .bold()
                        .padding(.vertical)
                }
                
                ForEach(instructionPart.steps, id: \.number) { instruction in
                    HStack(alignment: .top, spacing: 20) {
                        subtitleText(text: String(instruction.number))
                            .bold()
                        
                        subtitleText(text: instruction.step)
                    }
                }
            }
        }
        .padding()
    }
}
