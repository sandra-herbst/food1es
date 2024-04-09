//
//  food1esLocalizationEnTest.swift
//  food1esTests
//
//  Created by Matthias Stöppler on 29.06.22.
//

import XCTest

class food1esLocalizationEnTest: XCTestCase {
    
    //Set App Language to English to test
    func testEnLanguage(){
        XCTAssertEqual(NSLocalizedString("navTitleRecipeSearch", comment: ""), "Search")
        XCTAssertEqual(NSLocalizedString("navTitleGroceries", comment: ""), "Groceries")
        XCTAssertEqual(NSLocalizedString("unitTypeTitle", comment: ""), "Unit Type")
        XCTAssertEqual(NSLocalizedString("confirmButtonText", comment: ""), "Confirm")
        XCTAssertEqual(NSLocalizedString("baking", comment: ""), "Baking")
        XCTAssertEqual(NSLocalizedString("meat", comment: ""), "Meat and Seafood")
        XCTAssertEqual(NSLocalizedString("freshProduce", comment: ""), "Fruits and Vegetables")
    }
}
