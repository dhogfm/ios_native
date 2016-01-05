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
    
    let userObject: UserObject

    var signOutTapAction: Action<Void, Void, NSError>!
    var signOutCocoaAction: CocoaAction!

    init(user: UserObject, services: GFMServices) {
        userObject = user
        
        super.init(services: services)
                
        signOutTapAction = Action<Void, Void, NSError>() {
            self.executeSignOut()
            return SignalProducer.empty
        }
        
        signOutCocoaAction = CocoaAction(signOutTapAction, input: ())
    }
    
    // MARK: - Model Actions
    
    func executeSignOut() {
        print("Sign out call to Services")
    }

}
