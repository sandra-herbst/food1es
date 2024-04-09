//
//  CustomFilterView.swift
//  food1es
//
//  Created by Sandra Herbst on 16.06.22.
//

import SwiftUI

struct FilterView: View {
    
    @StateObject var viewModel: FilterViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    titleText(locale: LocalizedStringKey("filter"))
                    Spacer()
                    
                    Button {
                        viewModel.resetAllFilters()
                        
                    } label: {
                        Text(LocalizedStringKey("resetAll"))
                    }
                }
                .padding([.horizontal, .top])
                
                CustomDivider()
                cuisineFilter
                mealTypeFilter
            }
        }
    }
}

extension FilterView {

    var cuisineFilter: some View {
        VStack(alignment: .leading) {
            HStack {
                Menu {
                    ForEach(Cuisine.allCases.indices, id: \.self) { index in
                        Button {
                            viewModel.cuisineChecked[index].toggle()
                        } label: {
                            HStack {
                                CheckBoxView(checked: $viewModel.cuisineChecked[index], iconNotChecked: "", iconChecked: "checkmark")
                                subtitleText(text: Cuisine.allCases[index].localizedName)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.down")
                            .foregroundColor(ColorConstants.darkGreen)
                        subtitleText(locale: LocalizedStringKey("cuisine"))
                            .bold()
                        Spacer()
                    }
                }
                
                Button {
                    viewModel.resetCuisineSelection()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(ColorConstants.mainGreen)
                }
            }
            
            inactiveText(text: String(format: NSLocalizedString("amountSelected", comment: ""), "\(viewModel.getSelectedCuisines().count)"))
            // All selected cuisines in a cloud view
            CustomCloudView(tags: viewModel.getSelectedCuisines().map({ Cuisine in
                Cuisine.localizedName
            }))
        }
        .padding(.horizontal)
    }
    
    var mealTypeFilter: some View {
        VStack(alignment: .leading) {
            HStack {
                Menu {
                    ForEach(Meal.allCases.indices, id: \.self) { index in
                        Button {
                            viewModel.mealChecked[index].toggle()
                        } label: {
                            HStack {
                                CheckBoxView(checked: $viewModel.mealChecked[index], iconNotChecked: "", iconChecked: "checkmark")
                                subtitleText(text: Meal.allCases[index].localizedName)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "chevron.down")
                            .foregroundColor(ColorConstants.darkGreen)
                        subtitleText(locale: LocalizedStringKey("meal"))
                            .bold()
                        Spacer()
                    }
                }
                
                Button {
                    viewModel.resetMealSelection()
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(ColorConstants.mainGreen)
                }
            }
            
            inactiveText(text: String(format: NSLocalizedString("amountSelected", comment: ""), "\(viewModel.getSelectedMeals().count)"))
            // All selected cuisines in a cloud view
            CustomCloudView(tags: viewModel.getSelectedMeals().map({ Meal in
                Meal.localizedName
            }))
        }
        .padding(.horizontal)
    }
}

struct CustomFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(viewModel: FilterViewModel())
    }
}
