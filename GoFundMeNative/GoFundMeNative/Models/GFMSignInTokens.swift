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
        let responseCsrf = responseDict?["csrf"] as? String ?? ""
        csrf = responseCsrf

        let responsePassport = responseDict?["passport"] as? String ?? ""
        passport = responsePassport;
        
        let responseUserId = responseDict?["user_id"] as? String ?? ""
        userId = responseUserId;
    }
    
}
