//
//  GFMSignInTokens.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

class GFMSignInTokens: NSObject {
    let csrf: String
    let passport: String
    let userId: String
    
    init(responseDict: NSDictionary?) {
        // Is there a shortcut for this syntax?
        if let responseCsrf : String = responseDict?["csrf"] as? String {
            self.csrf = responseCsrf
        } else {
            self.csrf = ""
        }
        
        if let responsePassport : String = responseDict?["passport"] as? String {
            self.passport = responsePassport
        } else {
            self.passport = ""
        }
        
        if let responseUserId : String = responseDict?["user_id"] as? String {
            self.userId = responseUserId
        } else {
            self.userId = ""
        }
    }
    
}
