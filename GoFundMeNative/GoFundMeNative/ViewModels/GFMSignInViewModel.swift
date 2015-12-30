//
//  GFMSignInViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class GFMSignInViewModel: GFMViewModel {
    
    private var signInModel: GFMSignInModel
    let email: MutableProperty<String> = MutableProperty("")
    let password: MutableProperty<String> = MutableProperty("")

    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    
    var signInCocoaAction: CocoaAction!
    
    init(model: GFMSignInModel, services: GFMServices) {
        signInModel = model
        
        super.init(services: services)
        
        // have isvalidemail listen to email
        isValidEmail <~ self.email.producer.map(self.checkValidEmail)
        isValidPassword <~ self.password.producer.map(self.checkValidPassword)
        enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 }
        
        let signInTapAction = Action<Void, Void, NSError> {
            NSLog("Sign In Button Pressed")
            self.services.signIn(self.email.value, password: self.password.value) {
                (response) in
                NSLog("%@", response)
            }
            return SignalProducer.empty
        }
    
        signInCocoaAction = CocoaAction(signInTapAction, input: ())
    }
    
    func checkValidEmail(emailInput: String) -> Bool {
        return emailInput.characters.count > 3
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        return passwordInput.characters.count > 3
    }

}
