//
//  GFMServices.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import Foundation

typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()
typealias SignInSuccessBlock = (tokens: GFMSignInTokens?) -> ()

class GFMServices: NSObject {
    
    let networkService = GFMNetworkService()
    
    func signIn(email: String, password: String, completed: SignInSuccessBlock) {
        networkService.request(.SignIn(email, password), completion: {
            (success, responseDict, error) in
            var signInTokens : GFMSignInTokens?
            if (success) {
                // parser converts dict to object?
                signInTokens = GFMSignInTokens(responseDict: responseDict)
            }
            completed(tokens: signInTokens)
        })
    }
    
    func initializeApp() {
        networkService.request(.InitializeApp, completion: {
            (success, responseDict, error) in
            if (success) {
                if let csrf : String = responseDict?["csrf"] as? String {
                    gfm_csrf = csrf
                }
            }
        })
    }
}
