//
//  InfoView.swift
//  food1es
//
//  Created by Sandra Herbst on 25.05.22.
//

import SwiftUI

struct CustomInfoView: View {
    var text: String
    var iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.system(size: 16))
            
            Text(text)
                .font(.system(size: 12))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(ColorConstants.mainGreen)
        .cornerRadius(.infinity)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        CustomInfoView(text: "Placeholder", iconName: "heart")
    }
}
