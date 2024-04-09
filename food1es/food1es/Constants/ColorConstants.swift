//
//  ColorConstants.swift
//  food1es
//
//  Created by Sandra Herbst on 24.05.22.
//

import Foundation
import SwiftUI

struct ColorConstants {
    static let mainGreen = Color(red: 55/255, green: 118/255, blue: 49/255)
    static let darkGreen = Color(red: 32/255, green: 70/255, blue: 29/255)
    static let confirmGreen = Color(red: 140/255, green: 255/255, blue: 152/255)
    static let alertRed = Color(red: 255/255, green: 33/255, blue: 74/255)
    static let blueHighlight = Color(red: 137/255, green: 160/255, blue: 210/255)
    static let black = Color(red: 0/255, green: 0/255, blue: 0/255)
    static let grey = Color(red: 217/255, green: 217/255, blue: 217/255)
    static let inactiveColor = mainGreen.opacity(0.25)
    static let inactiveColor2 = mainGreen.opacity(0.1)
    static let inactiveColor3 = mainGreen.opacity(0.6)
}
