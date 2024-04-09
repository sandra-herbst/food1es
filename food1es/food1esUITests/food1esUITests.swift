//
//  food1esUITests.swift
//  food1esUITests
//
//  Created by Matthias Stöppler on 29.06.22.
//

import XCTest

class food1esUITests: XCTestCase {
    
    func testNavBarButtons() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["saveUserName"].tap()
        app.images["Suchen"].tap()
        app.images["Einkaufstasche"].tap()
        app.images["Blatt"].tap()
    }
    
    func testSearchRecipe() throws {
        let app = XCUIApplication()
        let inputField = app.textFields["searchRecipeText"]
        
        app.launch()
        app.buttons["saveUserName"].tap()
        app.images["Suchen"].tap()
        inputField.tap()
        inputField.typeText("burger")
    }
    
    func testAddGroceryItem() throws {
        let app = XCUIApplication()
        let floatingButton = app.otherElements["openAddShoppingItemModal"]
        
        app.launch()
        app.buttons["saveUserName"].tap()
        app.images["Einkaufstasche"].tap()
        floatingButton.tap()
    }
    
}
