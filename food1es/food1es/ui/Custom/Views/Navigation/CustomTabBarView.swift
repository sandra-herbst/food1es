//
//  TabControllerView.swift
//  food1es
//
//  Created by Sandra Herbst on 24.05.22.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        VStack(spacing: 0) {
            CustomDivider()
            
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Spacer()
                    tabView(tab: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                    Spacer()
                }
            }
            .padding(.horizontal)
            .background(Color.white.ignoresSafeArea(edges: .bottom))
        }
    }
}

extension CustomTabBarView {
    
    private func tabView(tab: TabBarItem) -> some View {
    let isSelected = selection == tab
        return VStack {
            if (isSelected) {
                CustomDivider(color: ColorConstants.mainGreen, height: 3.5, width: 60)
                    .padding(.bottom, 4)
                    .transition(.scale)
            }
            Spacer()
            Image(systemName: tab.iconName)
                .font(.system(size: 28, weight: .bold))
        }
        .foregroundColor(isSelected ? ColorConstants.mainGreen : ColorConstants.inactiveColor)
        .frame(maxWidth: .infinity, maxHeight: 45)
    }
    
    private func switchToTab(tab: TabBarItem) {
        withAnimation(.easeIn(duration: 0.25)) {
            selection = tab
        }
    }
}

struct TabControllerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .search, .favorites, .shopping, .ingredients
    ]
    
    static var previews: some View {
        VStack {
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
        }
    }
}
