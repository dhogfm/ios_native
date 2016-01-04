//
//  GFMPersistenceServiceTestCase.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import XCTest
import RealmSwift

class GFMPersistenceServiceTestCase: XCTestCase {
    
    var persistenceService: GFMPersistenceService!
    var tokens: GFMSignInTokens!
    
    let userId = "1"
    let csrf = "csrf"
    let passport = "passport"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        persistenceService = GFMPersistenceService(configuration: Realm.Configuration(inMemoryIdentifier: "TestRealmConfiguration"))
        tokens = GFMSignInTokens(responseDict: ["user_id" : userId,
                                                "csrf" : csrf,
                                                "passport" : passport])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStoreUserObject() {
        
        // should be empty
        var userObject = persistenceService.storedUserObject(userId)
        XCTAssertNil(userObject, "User object should be empty")
        
        persistenceService.storeAppTokens(tokens)
        
        // should retrieve one
        userObject = persistenceService.storedUserObject(userId)
        XCTAssertNotNil(userObject, "User object should be stored")
    
        XCTAssertEqual(tokens.userId, userObject?.userId, "User id should be stored correctly")
        XCTAssertEqual(tokens.csrf, userObject?.csrf, "csrf should be stored correctly")
        XCTAssertEqual(tokens.passport, userObject?.passport, "passport should be stored correctly")
    }
    
}
