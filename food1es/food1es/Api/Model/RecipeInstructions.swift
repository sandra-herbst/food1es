//
//  RecipeInstructions.swift
//  food1es
//
//  Created by Sandra Herbst on 14.06.22.
//

import Foundation

struct RecipeInstruction: Decodable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let steps: [RecipeInstructionStep]
    
    private enum CodingKeys: String, CodingKey {
        case name, steps
    }
}

struct RecipeInstructionStep: Decodable {
    let number: Int
    // Description of the step, example: "Pat the cickpeas dry with a paper towel..."
    let step: String
}
