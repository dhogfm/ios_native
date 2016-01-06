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
    @IBOutlet weak var errorLabel: UILabel!
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
        viewModel.emailTextFieldTextColor.producer.startWithNext { color in
            self.emailTextField.textColor = color
        }
        
        viewModel.password <~ passwordTextField.rac_textSignalProducer()
        viewModel.passwordTextFieldTextColor.producer.startWithNext { color in
            self.passwordTextField.textColor = color
        }

        viewModel.enableSignInButton.producer.startWithNext { isEnabled in
            self.signInButton.enabled = isEnabled
        }
        
        errorLabel.rac_hidden <~ viewModel.hideErrorMessage
        
        loadingActivityIndicatorView.rac_hidden <~ viewModel.signInTapAction.executing.producer.map({ !$0 })
        signInButton.addTarget(viewModel.signInCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
    }
}

