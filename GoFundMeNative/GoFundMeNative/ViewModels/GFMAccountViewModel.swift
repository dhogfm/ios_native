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
    
    let userObject: UserState
    
    // Actions
    lazy var signOutTapAction: Action<Void, Void, NSError> = { [unowned self] in
        return Action( { _ in
            self.executeSignOut()
            return SignalProducer.empty
        })
    }()
    
    var signOutCocoaAction: CocoaAction!

    init(user: UserState, services: GFMServices) {
        userObject = user
        super.init(services: services)
        signOutCocoaAction = CocoaAction(signOutTapAction, input: ())
    }
    
    // MARK: - Model Actions
    
    func executeSignOut() {
        let signInModel = GFMSignInModel()
        let signInViewModel = GFMSignInViewModel(model: signInModel, services: services)

        services.popToSignIn(signInViewModel)
    }
}
