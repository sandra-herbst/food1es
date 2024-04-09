//
//  WelcomeScreenView.swift
//  food1es
//
//  Created by Matthias Stöppler on 27.06.22.
//

import SwiftUI

struct WelcomeScreen: View {
    @StateObject private var viewModel: WelcomeScreenViewModel = WelcomeScreenViewModel()
    @State var selection: Int? = nil
    
    var body: some View {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        NavigationView {
            VStack(alignment: .leading) {
                titleText(locale: LocalizedStringKey("welcome"))
                    .padding(.horizontal)
                
                CustomTextFieldView(text: $viewModel.nameInput, promptText: "namePrompt")
                    .padding(.horizontal)
                
                NavigationLink(destination: AppTabBarView().environment(\.managedObjectContext, viewContext),tag: 1, selection: $selection){
                    Button(action: {
                        viewModel.saveUserName()
                        self.selection = 1
                    }){
                        Text(LocalizedStringKey("lets go"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 0))
                            .padding(3)
                            .background(viewModel.isValidName() ? ColorConstants.mainGreen : ColorConstants.inactiveColor3)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding()
                    }.accessibility(identifier: "saveUserName")
                }
            }
        }
    }
    
    struct WelcomeScreen_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeScreen()
        }
    }
}

