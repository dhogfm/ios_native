//
//  GFMServices.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit

typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()

class GFMServices: NSObject {
    
    let networkService = GFMNetworkService()
    
    func signIn(email: String, password: String, completed: DictionaryParameterBlock) {
        networkService.request(.SignIn(email, password), completion: {
            (success, responseDict, error) in
            if (success) {
                completed(response: responseDict)
            }
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
