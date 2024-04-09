//
//  Cuisine.swift
//  food1es
//
//  Created by Sandra Herbst on 16.06.22.
//

import Foundation

enum Cuisine: String, CaseIterable, Equatable, Decodable {
    case african = "african"
    case american = "american"
    case british = "british"
    case cajun = "cajun"
    case caribbean = "caribbean"
    case chinese = "chinese"
    case easternEuropean = "eastern european"
    case european = "european"
    case french = "french"
    case german = "german"
    case greek = "greek"
    case indian = "indian"
    case irish = "irish"
    case italian = "italian"
    case japanese = "japanese"
    case jewish = "jewish"
    case korean = "korean"
    case latinAmerican = "latin american"
    case mediterranean = "mediterranean"
    case mexican = "mexican"
    case middleEastern = "middle eastern"
    case nordic = "nordic"
    case southern = "southern"
    case spanish = "spanish"
    case thai = "thai"
    case vietnamese = "vietnamese"
    case other = "other"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawString = try container.decode(String.self)
        
        if let cuisineType = Cuisine(rawValue: rawString.lowercased()) {
            self = cuisineType
        } else {
            self = .other
        }
    }
    
    var localizedName: String {
        self.rawValue.localized
    }
}
