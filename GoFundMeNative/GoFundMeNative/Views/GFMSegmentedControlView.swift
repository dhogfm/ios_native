//
//  GFMSegmentedControlView.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/8/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

class GFMSegmentedControlView: UIView {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    class func instanceFromNib() -> GFMSegmentedControlView {
        return NSBundle.mainBundle().loadNibNamed("GFMSegmentedControlView", owner: nil, options: nil)[0] as! GFMSegmentedControlView
    }
}
