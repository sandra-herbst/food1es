//
//  CustomTextField.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var text: String
    var promptText: LocalizedStringKey
    var onSubmit: (() async -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .center) {
                        HStack {
                            TextField("", text: $text)
                                .onSubmit {
                                    Task {
                                        if (onSubmit != nil) {
                                            await onSubmit!()
                                        }
                                    }
                                }
                        }
                        .modifier(CustomViewModifier(roundedCornes: 8, textColor: ColorConstants.mainGreen))
                        .placeholder(when: text.isEmpty) {
                            Text(promptText).foregroundColor(ColorConstants.inactiveColor3)
                                .padding()
                    }
            }
    }
}

struct CustomViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes)
                .stroke(ColorConstants.mainGreen, lineWidth: 1.5))
            .shadow(radius: 10)
        
    }
}

struct CustomTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomTextFieldView(text: .constant(""), promptText: "Search ...")
    }
}
