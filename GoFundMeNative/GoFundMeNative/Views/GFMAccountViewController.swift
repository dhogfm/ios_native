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
        
        title = Constants.PageTitles.AccountPageTitle
        
        setupViewModelBindings()
        
        DynamicProperty(object: userIDLabel, keyPath: "text") <~ (accountViewModel?.userId.producer.map({ $0 as AnyObject? }))!
    }
    
    // MARK: - View Model Bindings
    
    func setupViewModelBindings() {
        guard let viewModel = accountViewModel else {
            print(Constants.Errors.ViewModelCreationError)
            return
        }
        
        signOutButton.addTarget(viewModel.signOutCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
    }

}
