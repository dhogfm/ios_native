//
//  GFMNavigationService.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/4/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

class GFMNavigationService: NSObject {
    
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Navigation Methods
    
    func navigateToPage(pageType: PageType, viewModel: GFMViewModel, animated: Bool, popCurrent: Bool) {
        if (popCurrent && self.navigationController?.viewControllers.count > 0) {
            self.navigationController?.viewControllers.removeAtIndex((self.navigationController?.viewControllers.count)! - 1)
        }
        
        navigateToPage(pageType, viewModel: viewModel, animated: animated)
    }
    
    func navigateToPage(pageType: PageType, viewModel: GFMViewModel, animated: Bool) {
        switch pageType {
        case .SignIn:
            if let signInViewController = fetchViewControllerWithIdentifier(PageType.SignIn.rawValue) as? GFMSignInViewController {
                
                if viewModel.isKindOfClass(GFMSignInViewModel) {
                    signInViewController.signInViewModel = viewModel as? GFMSignInViewModel
                }
                
                navigationController?.pushViewController(signInViewController, animated: animated)
            }
        case .Account:
            if let accountViewController = fetchViewControllerWithIdentifier(PageType.Account.rawValue) as? GFMAccountViewController {
                
                if viewModel.isKindOfClass(GFMAccountViewModel) {
                    accountViewController.accountViewModel = viewModel as? GFMAccountViewModel
                }
                
                navigationController?.pushViewController(accountViewController, animated: animated)
            }
        }
    }
    
    func popToSignIn(services: GFMServices, viewModel: GFMSignInViewModel) {
        if let signInViewController = fetchViewControllerWithIdentifier(PageType.SignIn.rawValue) as? GFMSignInViewController {
            
            if viewModel.isKindOfClass(GFMSignInViewModel) {
                signInViewController.signInViewModel = viewModel
            }
            
            navigationController?.viewControllers = [ signInViewController ]
        }
    }
    
    // MARK: - Helper Methods
    
    func fetchViewControllerWithIdentifier(storyboardIdentifier: String) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = mainStoryboard.instantiateViewControllerWithIdentifier(storyboardIdentifier) as UIViewController? else {
            print(Constants.Errors.ViewControllerFetchError + storyboardIdentifier)
            return UIViewController()
        }
        
        return viewController
    }
    
    

}
