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

class GFMRepository: NSObject {
    // accessing each realm needs to happen on the same thread
    var realmConfiguration = Realm.Configuration()
    
    convenience init(configuration: Realm.Configuration) {
        self.init()
        realmConfiguration = configuration
    }
    
    func storeAppTokens(tokens: GFMSignInTokens) {
        let realm = try! Realm(configuration: realmConfiguration)
        
        let userObject = UserObject()
        userObject.userId = tokens.userId
        userObject.csrf = tokens.csrf
        userObject.passport = tokens.passport
        
        try! realm.write {
            realm.add(userObject, update: true)
        }
    }
    
    func storedUserObject(userId: String) -> UserObject? {
        let realm = try! Realm(configuration: realmConfiguration)
        
        var userObject: UserObject?
        let userObjects = realm.objects(UserObject).filter("userId = '\(userId)'")
        if userObjects.count > 0 {
            userObject = userObjects.first!
        }
        return userObject
    }
}
