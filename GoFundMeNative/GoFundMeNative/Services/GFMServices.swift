//
//  GFMServices.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa

typealias BoolParameterBlock = (isTrue: Bool) -> ()
typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()
typealias SignInSuccessBlock = (tokens: GFMSignInTokens?) -> ()

// What's the best practice on constants?
let defaultsUserIdKey = "userId"

class UserState: NSObject {
    var userId: MutableProperty<String> = MutableProperty("")
}

class GFMServices: NSObject {
    
    private let persistenceService = GFMPersistenceService()
    private let networkService = GFMNetworkService()
    var navigationService: GFMNavigationService?
    let userState = UserState()
    
    func initializeApp() -> Bool {
        var isLoggedIn = false
        if let userObject = loadStoredUser() {
            gfm_csrf = userObject.csrf
            gfm_passport = userObject.passport
            isLoggedIn = true
        }
        
        networkService.request(.InitializeApp, completion: { [unowned self]
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

    func signIn(email: String, password: String, completed: BoolParameterBlock) {
        networkService.request(.SignIn(email, password), completion: { [unowned self]
            (success, responseDict, error) in
            var isValidLogin = false
            if (success) {
                let tokens = GFMSignInTokens(responseDict: responseDict)
                self.persistenceService.storeAppTokens(tokens)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(tokens.userId, forKey: defaultsUserIdKey)
                defaults.synchronize()
                
                if (tokens.userId.characters.count > 0) {
                    self.userState.userId.value = tokens.userId
                    isValidLogin = true
                }
            }
            completed(isTrue: isValidLogin)
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
            if uid.characters.count > 0 {
                userState.userId.value = uid
                return persistenceService.storedUserObject(uid)
            }
        }
        return nil
    }
    
    private func handleIsLoggedIn(isLoggedIn: Bool) {
        NSLog("User is logged in: \(isLoggedIn)")
    }
    
    // MARK: - Navigation Service
    
    func navigateToPage(pageType: PageType, viewModel: GFMViewModel, animated: Bool, popCurrent: Bool) {
        navigationService?.navigateToPage(pageType, viewModel: viewModel, animated: animated, popCurrent: popCurrent)
    }
    
    func navigateToPage(pageType: PageType, viewModel: GFMViewModel, animated: Bool) {
        navigationService?.navigateToPage(pageType, viewModel: viewModel, animated: animated)
    }
    
    func popToSignIn(viewModel: GFMSignInViewModel) {
        navigationService?.popToSignIn(self, viewModel: viewModel)
    }
}
