//
//  GFMNavigationService.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

enum PageType: String {
    case SignIn = "SignInViewController",
         Account = "AccountViewController"
}

class GFMNavigationService: NSObject {
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func navigateToPage(pageType: PageType, animated: Bool) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        switch pageType {
        case .SignIn:
            guard let signInViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SignInViewController") as? GFMSignInViewController else {
                print("There was a problem fetching the Sign In View Controller from Storyboard")
                return
            }
            
            navigationController?.pushViewController(signInViewController, animated: animated)
        case .Account:
            guard let accountViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AccountViewController") as? GFMSignInViewController else {
                print("There was a problem fetching the Account View Controller from Storyboard")
                return
            }
            
            navigationController?.pushViewController(accountViewController, animated: animated)
        }
    }
    
    func popToSignIn() {
        
    }

}
