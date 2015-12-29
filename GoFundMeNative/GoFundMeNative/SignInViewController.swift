//
//  SignInViewController.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import ReactiveCocoa

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let signInModel: SignInModel
    let signInViewModel: SignInViewModel
    
    init() {
        self.signInModel = SignInModel()
        self.signInViewModel = SignInViewModel(model: self.signInModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.signInModel = SignInModel()
        self.signInViewModel = SignInViewModel(model: self.signInModel)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupBindings()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBindings() {
        let emailProducer = emailTextField.rac_textSignalProducer()
        self.signInViewModel.email <~ emailProducer
        self.signInViewModel.isValidEmail.producer.startWithNext { isValid in
            if (isValid) {
                NSLog("email is valid")
            }
        }
        
        let passwordProducer = passwordTextField.rac_textSignalProducer()
        self.signInViewModel.password <~ passwordProducer
        self.signInViewModel.isValidPassword.producer.startWithNext { isValid in
            if (isValid) {
                NSLog("password is valid")
            }
        }
        
        self.signInViewModel.enableSignInButton.producer.startWithNext { isEnabled in
            self.signInButton.enabled = isEnabled
        }
    }

    @IBAction func onSignInTap(sender: AnyObject) {
    }
}

