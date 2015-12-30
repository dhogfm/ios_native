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
    
    var signInViewModel: GFMSignInViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupBindings()
    }
    
    func setupBindings() {
        let emailProducer = emailTextField.rac_textSignalProducer()
        
        if let viewModel = self.signInViewModel {
            viewModel.email <~ emailProducer
            viewModel.isValidEmail.producer.startWithNext { isValid in
                if (isValid) {
                    NSLog("email is valid")
                }
            }
            
            let passwordProducer = passwordTextField.rac_textSignalProducer()
            viewModel.password <~ passwordProducer
            viewModel.isValidPassword.producer.startWithNext { isValid in
                if (isValid) {
                    NSLog("password is valid")
                }
            }
            
            viewModel.enableSignInButton.producer.startWithNext { isEnabled in
                self.signInButton.enabled = isEnabled
            }
            
            signInButton.addTarget(viewModel.signInCocoaAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        }
    }

    @IBAction func onSignInTap(sender: AnyObject) {
    }
}

