//
//  CustomDivider.swift
//  food1es
//
//  Created by Sandra Herbst on 24.05.22.
//

import SwiftUI

struct CustomDivider: View {
    var color: Color = ColorConstants.grey
    var height: Double = 1.5
    var width: Double = .infinity
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: height, alignment: .center)
            .foregroundColor(color)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
