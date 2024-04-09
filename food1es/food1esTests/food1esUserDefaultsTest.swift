//
//  food1esUserDefaultsTest.swift
//  food1esTests
//
//  Created by Matthias Stöppler on 29.06.22.
//

import XCTest

class food1esUserDefaultsTest: XCTestCase {
    
    func testUserDefaults(){
        
        let username = "TestUser"
        UserDefaults.standard.set(username, forKey: "usernamekey")
        XCTAssertEqual(username, UserDefaults.standard.object(forKey:"usernamekey") as? String ?? String())
    }
    
}
