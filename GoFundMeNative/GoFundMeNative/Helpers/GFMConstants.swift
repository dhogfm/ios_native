//
//  GFMConstants.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/5/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

enum PageType: String {
    case Account = "AccountViewController",
         Feed = "FeedViewController",
         Settings = "",
         SignIn = "SignInViewController"
    
    func pageTitle() -> String {
        switch self {
        case .Account:
            return NSLocalizedString("My Account", comment: "My Account Page Title")
        case .Feed:
            return NSLocalizedString("Feed", comment: "Feed Page Title")
        case .Settings:
            return NSLocalizedString("Settings", comment: "Settings Page Title")
        case .SignIn:
            return NSLocalizedString("Sign In", comment: "Sign In Page Title")
        }
    }
}

struct Constants {
    struct Text {
        static let signOut = NSLocalizedString("Sign Out", comment: "Sign Out")
    }
    
    struct Errors {
        static let ViewControllerFetchError = "There was a problem fetching the View Controller from Storyboard with identifier:"
        static let ViewModelCreationError = "There was an error creating the view model"
    }
    
    struct Sizes {
        static let SegmentedControlViewHeight: CGFloat = 70
    }
    
    struct Animation {
        static let DefaultAnimationDuration = 0.5
        static let SegmentedControlHideOffset: CGFloat = 70
    }
}

typealias BoolParameterBlock = (isTrue: Bool) -> ()
typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()
