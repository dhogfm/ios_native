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
    
    // Inputs
    
    // Outputs
    var userId: MutableProperty<String> = MutableProperty("")
    
    // Actions
    lazy var signOutTapAction: Action<Void, Void, NSError> = { [unowned self] in
        return Action( { _ in
            return self.executeSignOut()
        })
    }()
    var signOutCocoaAction: CocoaAction!

    private let userObject: UserState
    
    init(user: UserState, services: GFMServices) {
        userObject = user
        super.init(services: services)
        
        userId = userObject.userId
        
        signOutCocoaAction = CocoaAction(signOutTapAction, input: ())
    }
    
    // MARK: - Model Actions
    
    func executeSignOut() -> SignalProducer<Void, NSError>  {
        let signInModel = GFMSignInModel()
        let signInViewModel = GFMSignInViewModel(model: signInModel, services: services)

        services.popToSignIn(signInViewModel)
        return SignalProducer.empty
    }
}
