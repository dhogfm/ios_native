//
//  GFMConstants.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/5/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

enum PageType: String {
    case SignIn = "SignInViewController",
    Account = "AccountViewController"
}

struct Constants {
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
