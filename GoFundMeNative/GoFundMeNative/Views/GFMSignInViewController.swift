//
//  GFMSignInViewController.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GFMSignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    
    var signInViewModel: GFMSignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelBindings()
    }
    
    // MARK: - View Model Bindings
    
    func setupViewModelBindings() {
        guard let viewModel = signInViewModel else {
            print(Constants.Errors.ViewModelCreationError)
            return
        }
        
        viewModel.email <~ emailTextField.rac_textSignalProducer()
        viewModel.isValidEmail.producer.startWithNext { isValid in
            if (isValid) {
                print("email is valid")
            }
        }
        
        viewModel.password <~ passwordTextField.rac_textSignalProducer()
        viewModel.isValidPassword.producer.startWithNext { isValid in
            if (isValid) {
                print("password is valid")
            }
        }
        
        viewModel.enableSignInButton.producer.startWithNext { isEnabled in
            self.signInButton.enabled = isEnabled
        }
        
        loadingActivityIndicatorView.rac_hidden <~ viewModel.signInTapAction.executing.producer.map({ !$0 })
        signInButton.addTarget(viewModel.signInCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
    }
}

