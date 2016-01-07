//
//  AppDelegate.swift
//  GoFundMeNative
//
//  Created by Daniel Ho on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit
import DrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let services = GFMServices()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup initial view
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = window else {
            print("There was a problem fetching the window")
            return false
        }
        
        window.backgroundColor = UIColor.whiteColor()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = mainStoryboard.instantiateInitialViewController() as? UINavigationController else {
            print("There was an error fetching navigation controller")
            return false
        }
        
        let isLoggedIn = services.initializeApp()
        
        if (isLoggedIn) {
            guard let accountViewController = mainStoryboard.instantiateViewControllerWithIdentifier("AccountViewController") as? GFMAccountViewController else {
                print("There was a problem fetching the Account View Controller from Storyboard")
                return false
            }
            
            let accountViewModel = GFMAccountViewModel.init(user: services.userState, services: services)
            accountViewController.accountViewModel = accountViewModel
            
            navigationController.viewControllers = [ accountViewController ]
        } else {
            guard let signInViewController = navigationController.viewControllers[0] as? GFMSignInViewController else {
                print("There was a problem fetching the Sign In View Controller from Storyboard")
                return false
            }
            
            let signInModel = GFMSignInModel()
            let signInViewModel = GFMSignInViewModel(model: signInModel, services: services)
            signInViewController.signInViewModel = signInViewModel
        }
        
        guard let sideMenuViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SideMenuViewController") as? GFMSideMenuViewController else {
            print("There was a problem fetching the Side Menu View Controller from Storyboard")
            return false
        }
        
        let signMenuViewModel = GFMSideMenuViewModel(services: services)
        sideMenuViewController.viewModel = signMenuViewModel
        
        let drawerController: DrawerController = DrawerController(centerViewController: navigationController, leftDrawerViewController: sideMenuViewController)
        
        services.navigationService = GFMNavigationService(navigationController: navigationController)

        window.rootViewController = drawerController
        window.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

