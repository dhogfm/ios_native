//
//  GFMSideMenuRow.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/11/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import ReactiveCocoa

enum SideMenuRow: Int {
    case ACCOUNT, FEED, SETTINGS, SIGNOUT
    
    func menuTitle() -> String {
        switch self {
        case .ACCOUNT:
            return "My Account"
        case .FEED:
            return "Feed"
        case .SETTINGS:
            return "Settings"
        case .SIGNOUT: 
            return "Sign Out"
        }
    }
    
    static let count: Int = {
        var max: Int = 0
        while let _ = SideMenuRow(rawValue: max) { max += 1 }
        return max
    }()
}
