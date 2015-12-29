//
//  SignInViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class SignInViewModel: NSObject {
    
    var signInModel: SignInModel
    let email: MutableProperty<String> = MutableProperty("")
    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    
    init(model: SignInModel) {
        self.signInModel = model
        
        super.init()
        
        // have isvalidemail listen to email
        self.isValidEmail <~ self.email.producer.map(self.isValidEmail)
        
    }
    
    func isValidEmail(emailInput: String) -> Bool {
        return emailInput.characters.count > 3
    }
}
