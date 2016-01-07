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
    
    private let signInModel: GFMSignInModel
    private var hasTappedSignIn = false
    
    // Inputs
    let email: MutableProperty<String> = MutableProperty("")
    let password: MutableProperty<String> = MutableProperty("")

    // Outputs
    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    let hideErrorMessage: MutableProperty<Bool> = MutableProperty(true)
    let emailTextFieldTextColor: MutableProperty<UIColor> = MutableProperty(UIColor.lightGrayColor())
    let passwordTextFieldTextColor: MutableProperty<UIColor> = MutableProperty(UIColor.lightGrayColor())
    
    // Actions
    lazy var signInTapAction: Action<Void, Bool, NoError> = { [unowned self] in
        return Action ({ _ in
            self.hasTappedSignIn = true
            return self.executeSignIn(self.email.value, password: self.password.value)
        })
    }()
    var signInCocoaAction: CocoaAction!
    
    init(model: GFMSignInModel, services: GFMServices) {
        signInModel = model
        
        super.init(services: services)
        
        isValidEmail <~ email.producer.map(checkValidEmail)
        isValidPassword <~ password.producer.map(checkValidPassword)
        enableSignInButton <~ combineLatest(isValidEmail.producer, isValidPassword.producer)
            .map { $0 && $1 && !self.signInTapAction.executing.value }
        emailTextFieldTextColor <~ isValidEmail.producer.map(validatedTextColor)
        passwordTextFieldTextColor <~ isValidPassword.producer.map(validatedTextColor)
    
        signInCocoaAction = CocoaAction(signInTapAction, input: ())
        self.signInTapAction.events
            .observeOn(UIScheduler())
            .observeNext({ [unowned self] event in
                switch event {
                case .Next:
                    if let isSuccessfullyLoggedIn = event.value as Bool? {
                        NSLog("\(isSuccessfullyLoggedIn)")
                        if (event.value!) {
                            let accountViewModel = GFMAccountViewModel.init(user: self.services.userState, services: self.services)
                            self.services.navigateToPage(.Account, viewModel: accountViewModel, animated: true)
                        }
                        self.hideErrorMessage.value = isSuccessfullyLoggedIn
                    }
                case .Completed:
                    NSLog("finished")
                case .Interrupted:
                    NSLog("Interrupted")
                case .Failed:
                    NSLog("Failed")
                    break
                }
        })
    }
    
    // MARK: - Mutable Property Bindings
    
    func checkValidEmail(emailInput: String) -> Bool {
        // TODO: get email validation code from server
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(emailInput)
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        // TODO: get password validation code from server
        return passwordInput.characters.count > 3
    }
    
    private func validatedTextColor(isValid: Bool) -> UIColor {
        if (!self.hasTappedSignIn) {
            return UIColor.blackColor()
        } else {
            return isValid ? UIColor.blackColor() : UIColor.redColor()
        }
    }
    
    // MARK: - Model Actions

    func executeSignIn(email: String, password: String) -> SignalProducer<Bool, NoError>{
        let producer = SignalProducer<Bool, NoError> { [unowned self] (observer, disposable) in
            self.services.signIn(email, password: password) { (isSignedIn) in
                observer.sendNext(isSignedIn)
                observer.sendCompleted()
            }
        }
        return producer
    }
}
