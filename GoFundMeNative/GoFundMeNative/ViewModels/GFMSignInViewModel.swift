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
    let isValidEmail: MutableProperty<Bool> = MutableProperty(false)
    let isValidPassword: MutableProperty<Bool> = MutableProperty(false)
    let enableSignInButton: MutableProperty<Bool> = MutableProperty(false)
    
    // Actions
    lazy var signInTapAction: Action<Void, Bool, NoError> = { [unowned self] in
        return Action ({ _ in
            return self.executeSignIn(self.email.value, password: self.password.value)
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
        
        self.signInTapAction.events
            .observeOn(UIScheduler())
            .observeNext({ event in
                switch event {
                case .Next:
                    NSLog("\(event.value!)")
                    if (event.value!) {
                        let accountViewModel = GFMAccountViewModel.init(user: self.services.userState, services: self.services)
                        self.services.navigateToPage(.Account, viewModel: accountViewModel, animated: true)
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
        return emailInput.characters.count > 3
    }
    
    func checkValidPassword(passwordInput: String) -> Bool {
        return passwordInput.characters.count > 3
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
