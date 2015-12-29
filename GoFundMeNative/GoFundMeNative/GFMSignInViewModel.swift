//
//  GFMSignInViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GFMSignInViewModel: NSObject {
    
    var signInModel: GFMSignInModel
    let email: MutableProperty<String> = MutableProperty("")
    let password: MutableProperty<String> = MutableProperty("")

    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    
    init(model: GFMSignInModel) {
        self.signInModel = model
        
        super.init()
        
        // have isvalidemail listen to email
        self.isValidEmail <~ self.email.producer.map(self.checkValidEmail)
        self.isValidPassword <~ self.password.producer.map(self.checkValidPassword)
        self.enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 }
    }
    
    func checkValidEmail(emailInput: String) -> Bool {
        return emailInput.characters.count > 3
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        return passwordInput.characters.count > 3
    }
}
