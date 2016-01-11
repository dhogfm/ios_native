//
//  GFMAccountViewController.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa
import DrawerController

class GFMAccountViewController: UIViewController {
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    var accountViewModel: GFMAccountViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Account"
        
        setupViewModelBindings()
        self.setupLeftMenuButton()
    }
    
    // MARK: - View Model Bindings
    
    func setupViewModelBindings() {
        guard let viewModel = accountViewModel else {
            print(Constants.Errors.ViewModelCreationError)
            return
        }
        
        signOutButton.addTarget(viewModel.signOutCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        
        let userIdLabelDynamicProperty = DynamicProperty(object: userIdLabel, keyPath: "text")
        viewModel.attachUserIdDynamicProperty(userIdLabelDynamicProperty)
    }
}
