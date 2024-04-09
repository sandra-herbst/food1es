//
//  food1esTests.swift
//  food1esTests
//
//  Created by Matthias Stöppler on 29.06.22.
//

import XCTest

class food1esLocalizationDeTests: XCTestCase {
    
    //Set App Language to De/German to test
    func testDeLanguage(){
        XCTAssertEqual(NSLocalizedString("navTitleRecipeSearch", comment: ""), "Suche")
        XCTAssertEqual(NSLocalizedString("navTitleGroceries", comment: ""), "Lebensmittel")
        XCTAssertEqual(NSLocalizedString("unitTypeTitle", comment: ""), "Einheit")
        XCTAssertEqual(NSLocalizedString("confirmButtonText", comment: ""), "Bestätigen")
        XCTAssertEqual(NSLocalizedString("baking", comment: ""), "Backwaren")
        XCTAssertEqual(NSLocalizedString("meat", comment: ""), "Fleisch und Meeresfrüchte")
        XCTAssertEqual(NSLocalizedString("freshProduce", comment: ""), "Früchte und Gemüse")
    }
    
}
