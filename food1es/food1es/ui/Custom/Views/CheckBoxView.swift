//
//  CustomCheckBox.swift
//  food1es
//
//  Created by Florian Winkler on 22.06.22.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    var iconNotChecked: String = "square"
    var iconChecked: String = "checkmark.square.fill"

    var body: some View {
        Image(systemName: checked ? iconChecked : iconNotChecked)
            .frame(width: 20)
            .foregroundColor(checked ? ColorConstants.mainGreen : ColorConstants.inactiveColor3)
            .onTapGesture {
                self.checked.toggle()
            }
            .cornerRadius(8)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    struct CheckBoxViewHolder: View {
        @State var checked = false

        var body: some View {
            CheckBoxView(checked: $checked)
        }
    }

    static var previews: some View {
        CheckBoxViewHolder()
    }
}
