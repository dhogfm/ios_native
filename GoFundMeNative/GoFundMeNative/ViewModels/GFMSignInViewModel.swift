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
    
    // Inputs
    let email: MutableProperty<String> = MutableProperty("")
    let password: MutableProperty<String> = MutableProperty("")

    // Outputs
    let isSignInExecuting: MutableProperty<Bool> = MutableProperty(false)
    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    
    // Actions
    lazy var signInTapAction: Action<Void, Void, NSError> = { [unowned self] in
        return Action(enabledIf: self.enableSignInButton, { _ in
            return self.executeSignIn()
        })
    }()
    
    var signInCocoaAction: CocoaAction!
    
    
    init(model: GFMSignInModel, services: GFMServices) {
        signInModel = model
        
        super.init(services: services)
        
        isValidEmail <~ self.email.producer.map(self.checkValidEmail)
        isValidPassword <~ self.password.producer.map(self.checkValidPassword)
        enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 }
    
        signInCocoaAction = CocoaAction(signInTapAction, input: ())
    }
    
    // MARK: - Mutable Property Bindings
    
    func checkValidEmail(emailInput: String) -> Bool {
        return emailInput.characters.count > 3
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        return passwordInput.characters.count > 3
    }
    
    // MARK: - Model Actions

    func executeSignIn() -> SignalProducer<Void, NSError>{
        self.isSignInExecuting.value = true
        self.services.signIn(self.email.value, password: self.password.value) { [unowned self]
            (tokens) in
            self.isSignInExecuting.value = false
            
            self.services.navigateToPage(.Account, animated: true)
        }
        return SignalProducer.empty
    }
}
