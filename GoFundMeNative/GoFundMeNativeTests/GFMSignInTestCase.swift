//
//  GFMSignInTestCase.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import XCTest

class GFMSignInTestCase: XCTestCase {
    
    let viewModel = GFMSignInViewModel(model: GFMSignInModel(), services: GFMServices())
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testValidEmail() {
        let email = "dho@gofundme.com"
        let isValid = viewModel.checkValidEmail(email)
        XCTAssertTrue(isValid, "\(email) should be valid")
    }
    
    func testEmailNoAt() {
        let email = "dhogofundme.com"
        let isValid = viewModel.checkValidEmail(email)
        XCTAssertFalse(isValid, "\(email) needs an @")
    }
    
    func testBlankEmail() {
        let email = ""
        let isValid = viewModel.checkValidEmail(email)
        XCTAssertFalse(isValid, "\(email) is blank")
    }
    
    func testEmailNoEnd() {
        let email = "dho@gofundme"
        let isValid = viewModel.checkValidEmail(email)
        XCTAssertFalse(isValid, "\(email) needs a suffix")
    }
    
    func testValidPassword() {
        let password = "test123!"
        let isValid = viewModel.checkValidPassword(password)
        XCTAssertTrue(isValid, "\(password) should be valid")
    }
    
    func testShortPassword() {
        let password = "test12"
        let isValid = viewModel.checkValidPassword(password)
        XCTAssertFalse(isValid, "\(password) should be at least 6 characters")
    }
    
    func testBlankPassword() {
        let password = ""
        let isValid = viewModel.checkValidPassword(password)
        XCTAssertFalse(isValid, "\(password) is blank")
    }
}
