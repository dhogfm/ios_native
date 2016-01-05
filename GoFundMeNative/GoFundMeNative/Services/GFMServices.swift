//
//  GFMServices.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import Foundation
import UIKit

typealias BoolParameterBlock = (isTrue: Bool) -> ()
typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()
typealias SignInSuccessBlock = (tokens: GFMSignInTokens?) -> ()

// What's the best practice on constants?
let defaultsUserIdKey = "userId"

class UserState: NSObject {
    var userId: String = ""
}

class GFMServices: NSObject {
    
    private let persistenceService = GFMPersistenceService()
    private let networkService = GFMNetworkService()
    var navigationService: GFMNavigationService?
    var userState = UserState()
    
    func initializeApp() -> Bool {
        var isLoggedIn = false
        if let userObject = self.loadStoredUser() {
            gfm_csrf = userObject.csrf
            gfm_passport = userObject.passport
            isLoggedIn = true
        }
        
        networkService.request(.InitializeApp, completion: {
            (success, responseDict, error) in
            if (success) {
                if let csrf : String = responseDict?["csrf"] as? String {
                    gfm_csrf = csrf
                }
                
                if let isLoggedIn : Bool = responseDict?["loggedIn"] as? Bool {
                    self.handleIsLoggedIn(isLoggedIn)
                }
            }
        })
        
        return isLoggedIn
    }

    func signIn(email: String, password: String, completed: SignInSuccessBlock) {
        networkService.request(.SignIn(email, password), completion: {
            (success, responseDict, error) in
            var signInTokens : GFMSignInTokens?
            if (success) {
                let tokens = GFMSignInTokens(responseDict: responseDict)
                self.persistenceService.storeAppTokens(tokens)
                signInTokens = tokens
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(tokens.userId, forKey: defaultsUserIdKey)
                defaults.synchronize()
            }
            completed(tokens: signInTokens)
        })
    }
    
    func signOut(completed: BoolParameterBlock) {
        networkService.request(.SignOut, completion: {
            (success, responseDict, error) in
            completed(isTrue: success)
        })
    }
    
    // MARK: - Private methods
    
    private func loadStoredUser() -> UserObject? {
        let defaults = NSUserDefaults.standardUserDefaults()
        let userId = defaults.valueForKey(defaultsUserIdKey)
        if let uid = userId as? String {
            userState.userId = uid
            return persistenceService.storedUserObject(uid)
        } else {
            return nil
        }
    }
    
    private func handleIsLoggedIn(isLoggedIn: Bool) {
        NSLog("User is logged in: \(isLoggedIn)")
    }
    
    // MARK: - Navigation Service
    
    func navigateToPage(pageType: PageType, animated: Bool) {
        self.navigationService?.navigateToPage(pageType, animated: animated)
    }
    
    func popToSignIn() {
        self.navigationService?.popToSignIn(self)
    }
}
