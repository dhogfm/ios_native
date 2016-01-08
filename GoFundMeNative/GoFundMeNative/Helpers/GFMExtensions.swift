//
//  GFMExtensions.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/7/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit
import DrawerController

extension UIViewController {
    
    // MARK: Bar Button Items
    
    func setupLeftMenuButton() {
        let leftDrawerButton = DrawerBarButtonItem(target: self, action: "leftDrawerButtonPress:")
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }
    
    // MARK: - Button Handlers
    
    func leftDrawerButtonPress(sender: AnyObject?) {
        UIApplication.sharedApplication().statusBarHidden = !UIApplication.sharedApplication().statusBarHidden
        self.evo_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
}
