//
//  GFMPersistenceService.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import Foundation
import RealmSwift

class UserObject: Object {
    dynamic var userId = ""
    dynamic var csrf = ""
    dynamic var passport = ""
    
    override static func primaryKey() -> String? {
        return "userId"
    }
}

class GFMPersistenceService: NSObject {
    // accessing each realm needs to happen on the same thread
    
    func storeAppTokens(tokens: GFMSignInTokens) {
        let realm = try! Realm()
        
        let userObject = UserObject()
        userObject.userId = tokens.userId
        userObject.csrf = tokens.csrf
        userObject.passport = tokens.passport
        
        try! realm.write {
            realm.add(userObject, update: true)
        }
    }
    
    func storedUserObject(userId: String) -> UserObject? {
        let realm = try! Realm()
        
        var userObject: UserObject?
        let userObjects = realm.objects(UserObject).filter("userId = '\(userId)'")
        if userObjects.count > 0 {
            userObject = userObjects.first!
        }
        return userObject
    }
}
