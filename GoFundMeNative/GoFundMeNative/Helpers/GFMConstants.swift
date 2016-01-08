//
//  GFMConstants.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/5/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import Foundation

enum PageType: String {
    case SignIn = "SignInViewController",
    Account = "AccountViewController"
}

struct Constants {
    struct PageTitles {
        static let AccountPageTitle = "My Account"
    }
    
    struct Errors {
        static let ViewControllerFetchError = "There was a problem fetching the View Controller from Storyboard with identifier:"
        static let ViewModelCreationError = "There was an error creating the view model"
    }
}

typealias BoolParameterBlock = (isTrue: Bool) -> ()
typealias DictionaryParameterBlock = (response: NSDictionary?) -> ()
