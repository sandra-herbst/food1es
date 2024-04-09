//
//  CustomIngredientView.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

struct CustomListElementView: View {
    
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 16))
            .foregroundColor(.white)
            .padding()
            .background(color)
            .cornerRadius(8)
    }
}

struct CustomListElementButtonView: View {
    
    var text: String
    var color: Color
    var minWidth: CGFloat
    var onPressed: () -> Void
    
    var body: some View {
        Button {
            onPressed()
        } label: {
            Text(text)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: minWidth)
                .background(color)
                .cornerRadius(8)
        }
    }
}

struct CustomListElementView_Previews: PreviewProvider {
    static var previews: some View {
        CustomListElementView(text: "200g Käse", color: ColorConstants.mainGreen)
    }
}
