//
//  CustomText.swift
//  food1es
//
//  Created by Sandra Herbst on 27.05.22.
//

import SwiftUI

func titleText(text: String) -> Text {
    return Text(text)
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(ColorConstants.darkGreen)
}

func titleText(locale: LocalizedStringKey) -> Text {
    return Text(locale)
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(ColorConstants.darkGreen)
}

func subtitleText(text: String) -> Text {
    return Text(text)
        .font(.system(size: 18, weight: .regular))
        .foregroundColor(ColorConstants.darkGreen)
}

func inactiveText(text: String, size: CGFloat = 14) -> Text {
    return Text(text)
        .font(.system(size: size, weight: .regular))
        .foregroundColor(ColorConstants.inactiveColor3)
}

func subtitleText(locale: LocalizedStringKey) -> Text {
    return Text(locale)
        .font(.system(size: 18, weight: .regular))
        .foregroundColor(ColorConstants.darkGreen)
}

