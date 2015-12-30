//
//  GFMServices.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit

typealias DictionaryParameterBlock = (response: NSDictionary) -> ()

class GFMServices: NSObject {
    
    func signIn(email: String, password: String, completed: DictionaryParameterBlock) {
        GoFundMeProvider.request(.SignIn(email, password), completion: { result in
            var success = true
            var message = "Sign in error"
            
            switch result {
            case let .Success(response):
                do {
                    let json: NSDictionary? = try response.mapJSON() as? NSDictionary
                    if let json = json {
                        // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
                        //                        self.repos = json
                        completed(response: json)
                    } else {
                        success = false
                    }
                } catch {
                    success = false
                }
                //                self.tableView.reloadData()
            case let .Failure(error):
                guard let error = error as? CustomStringConvertible else {
                    break
                }
                message = error.description
                success = false
            }
            
            if !success {
                // handle error
            }
        })
    }
    
    func initializeApp() {
        GoFundMeProvider.request(.InitializeApp, completion:{ result in
            switch result {
            case let .Success(response):
                do {
                    let json: NSDictionary? = try response.mapJSON() as? NSDictionary
                    if let json = json {
                        // Presumably, you'd parse the JSON into a model object. This is just a demo, so we'll keep it as-is.
                        //                        self.repos = json
                        if let csrf : String = json["csrf"] as? String {
                            gfm_csrf = csrf
                        }
                        
                        if let passport : String = json["passport"] as? String {
                            gfm_passport = passport
                        }
                    }
                } catch {
                }
            case .Failure(_):
                break
            }
        })
    }
}
