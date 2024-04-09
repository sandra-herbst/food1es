//
//  RoundButton.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import SwiftUI

struct RoundIconButton: View {
    let iconName: String
    let backgroundColor: Color
    var onPressed: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                onPressed()
            }
        } label: {
            Image(systemName: iconName)
                .foregroundColor(.white)
                .padding()
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .padding()
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundIconButton(iconName: "chevron.backward", backgroundColor: ColorConstants.mainGreen) {
            print("pressed")
        }
    }
}
