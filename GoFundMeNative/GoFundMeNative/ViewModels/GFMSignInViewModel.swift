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
    
    var signInTapAction: Action<Void, Void, NSError>!
    var signInCocoaAction: CocoaAction!
    
    var isSignInExecuting: MutableProperty<Bool> = MutableProperty(false)
    
    init(model: GFMSignInModel, services: GFMServices) {
        signInModel = model
        
        super.init(services: services)
        
        isValidEmail <~ self.email.producer.map(self.checkValidEmail)
        isValidPassword <~ self.password.producer.map(self.checkValidPassword)
        enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 }
        
        signInTapAction = Action<Void, Void, NSError>() {
            self.isSignInExecuting.value = true
            self.executeSignIn()
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

    func executeSignIn() {
        self.services.signIn(self.email.value, password: self.password.value) {
            (response) in
            NSLog("%@", response)
            self.isSignInExecuting.value = false
        }
    }
}
