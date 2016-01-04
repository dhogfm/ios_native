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
    
    func navigateToPage(fromViewController: UIViewController, pageType: PageType, animated: Bool) {
        
    }

}
