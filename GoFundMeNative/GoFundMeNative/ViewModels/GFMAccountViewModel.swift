//
//  GFMAccountViewModel.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class GFMAccountViewModel: GFMViewModel {
    private let userObject: UserState
    // Inputs
    
    // Outputs

    // Actions
    lazy var signOutTapAction: Action<Void, Bool, NoError> = { [unowned self] in
        return Action( { _ in
            return self.executeSignOut()
        })
    }()
    var signOutCocoaAction: CocoaAction!
    
    init(user: UserState, services: GFMServices) {
        userObject = user
        super.init(services: services)
        setupModelActions()
    }
    
    // MARK: - Model Actions
    
    func setupModelActions() {
        signOutCocoaAction = CocoaAction(signOutTapAction, input: ())
        self.signOutTapAction.events
            .observeOn(UIScheduler())
            .observeNext({ [unowned self] event in
                switch event {
                case .Next:
                    if let isLoggedOut = event.value as Bool? {
                        if (isLoggedOut) {
                            let signInModel = GFMSignInModel()
                            let signInViewModel = GFMSignInViewModel(model: signInModel, services: self.services)
                            
                            self.services.popToSignIn(signInViewModel)
                        }
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
    
    func executeSignOut() -> SignalProducer<Bool, NoError>  {
        let producer = SignalProducer<Bool, NoError> { [unowned self] (observer, disposable) in
            self.services.signOut() { (isSignedOut) in
                observer.sendNext(isSignedOut)
                observer.sendCompleted()
            }
        }
        return producer
    }
    
    // MARK: - Dynamic Properties
    
    func attachUserIdDynamicProperty(dynamicProperty: DynamicProperty) {
        dynamicProperty <~ (userObject.userId.producer.map({ $0 as AnyObject? }))
    }
}
