//
//  GFMSideMenuRow.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/11/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import ReactiveCocoa

enum SideMenuRow: Int {
    case Account, Feed, Settings, SignIn, SignOut
    
    func menuTitle() -> String {
        switch self {
        case .Account:
            return PageType.Account.pageTitle()
        case .Feed:
            return PageType.Feed.pageTitle()
        case .Settings:
            return PageType.Settings.pageTitle()
        case .SignIn:
            return  PageType.Settings.pageTitle()
        case .SignOut:
            return NSLocalizedString("Sign Out", comment: "Sign Out Side Menu")
        }
    }
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SideMenuRow(rawValue: max) { max += 1 }
        return max
    }()
}
