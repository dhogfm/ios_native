//
//  GFMSignInModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit

class GFMSignInModel: NSObject {
    
    var emailString: String = ""
    var passwordString: String = ""
    
    override init() {
        super.init()
    }
    
    init(emailString : String, passwordString : String) {
        self.emailString = emailString
        self.passwordString = passwordString
    }

}
