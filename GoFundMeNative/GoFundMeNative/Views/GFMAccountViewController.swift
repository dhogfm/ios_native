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
        
        title = Constants.PageTitles.AccountPageTitle
        
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
    
    // MARK: Bar Button Items
    
    func setupLeftMenuButton() {
        let leftDrawerButton = DrawerBarButtonItem(target: self, action: "leftDrawerButtonPress:")
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }

    // MARK: - Button Handlers
    
    func leftDrawerButtonPress(sender: AnyObject?) {
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
}
