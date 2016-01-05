//
//  GFMAccountViewController.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GFMAccountViewController: UIViewController {
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    var accountViewModel: GFMAccountViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelBindings()
        
        if let userId = accountViewModel?.userObject.userId {
            self.userIDLabel.text! += " \(userId)"
        }

    }
    
    // MARK: - View Model Bindings
    
    func setupViewModelBindings() {
        guard let viewModel = self.accountViewModel else {
            print("There was an error creating the view model")
            return
        }
        
        signOutButton.addTarget(viewModel.signOutCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
    }

}
