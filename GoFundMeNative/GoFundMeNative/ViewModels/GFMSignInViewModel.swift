//
//  GFMSignInViewModel.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GFMSignInViewModel: GFMViewModel {
    
    private var signInModel: GFMSignInModel
    let email: MutableProperty<String> = MutableProperty("")
    let password: MutableProperty<String> = MutableProperty("")

    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    
    var signInCocoaAction: CocoaAction!
    var signInCommand: RACCommand?
    
    init(model: GFMSignInModel, services: GFMServices) {
        signInModel = model
        
        super.init(services: services)
        
        // have isvalidemail listen to email
        isValidEmail <~ self.email.producer.map(self.checkValidEmail)
        isValidPassword <~ self.password.producer.map(self.checkValidPassword)
        enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 }
        
        let signInAction = Action<Void, Void, NSError> {
            // TODO - Create next ViewModel, Push Model via Services
            NSLog("Pressed Button")
            return SignalProducer.empty
        }
        signInCocoaAction = CocoaAction(signInAction, input: ())
    }
    
    func checkValidEmail(emailInput: String) -> Bool {
        return emailInput.characters.count > 3
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        return passwordInput.characters.count > 3
    }

    func signIn(email: String, password: String) {
        self.services.signIn(email, password: password) {
            (response) in
            NSLog("%@", response)
        }
    }
}
