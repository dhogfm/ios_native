//
//  GFMViewModel.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 12/29/15.
//  Copyright © 2015 Daniel Ho. All rights reserved.
//

import UIKit

class GFMViewModel: NSObject {
    
    var services: GFMServices
    
    init(services: GFMServices) {
        self.services = services
    }
}
