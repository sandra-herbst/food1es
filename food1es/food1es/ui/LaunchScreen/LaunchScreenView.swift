//
//  LaunchScreen.swift
//  food1es
//
//  Created by Matthias Stöppler on 27.05.22.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = true
    @State private var size = 0.8
    @State private var opacity = 0.5
    var username = UserDefaults.standard.object(forKey: AppConstants.username_KEY) as? String ?? ""
    
    var body: some View {
        if !isActive {
            if username.isEmpty {
                WelcomeScreen()
            } else {
                let viewContext = CoreDataManager.shared.persistentContainer.viewContext
                AppTabBarView().environment(\.managedObjectContext, viewContext)
            }
            
        } else {
            VStack {
                Image("food1es")
                    .resizable()
                    .frame(width: 90, height: 90)
                
                Text(AppConstants.appName)
                    .fontWeight(.semibold)
                    .font(.system(size: 50))
                    .foregroundColor(ColorConstants.mainGreen)
                
                if !username.isEmpty {
                    Text(String(format: NSLocalizedString("welcomeUser", comment: ""), "\(username)"))
                        .foregroundColor(ColorConstants.mainGreen)
                        .fontWeight(.semibold)
                }
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear{
                withAnimation(.easeIn(duration: 1.2)){
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = false
                }
            }
        }
    }
    
    struct LaunchScreen_Previews: PreviewProvider {
        static var previews: some View {
            LaunchScreen()
        }
    }
}
