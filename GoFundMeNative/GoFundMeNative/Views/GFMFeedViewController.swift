//
//  GFMFeedViewController.swift
//  GoFundMeNative
//
//  Created by Alan Leatherman on 1/8/16.
//  Copyright © 2016 Daniel Ho. All rights reserved.
//

import UIKit

class GFMFeedViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    let segmentedControlView: GFMSegmentedControlView = GFMSegmentedControlView.instanceFromNib()
    var lastOffset: CGPoint?
    var isScrollingDown: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentedControlViewFrame = CGRect(x: 0, y: 60, width: UIScreen.mainScreen().bounds.width, height: Constants.Sizes.SegmentedControlViewHeight)
        segmentedControlView.frame = segmentedControlViewFrame
        self.view.addSubview(segmentedControlView)
        
        self.scrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 2000)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > lastOffset?.y && scrollView.contentOffset.y > 50) {
            if (isScrollingDown == false) {
                toggleSegmentedControl(false)
            }
        } else {
            if (isScrollingDown == true) {
                toggleSegmentedControl(true)
            }
        }
        
        lastOffset = scrollView.contentOffset
    }
    
    func toggleSegmentedControl(shouldShow: Bool) {
        UIView.animateWithDuration(Constants.Animation.DefaultAnimationDuration, animations: { _ in
            let segmentedControlYAnimation: CGFloat = shouldShow ? Constants.Sizes.SegmentedControlViewHeight : -Constants.Sizes.SegmentedControlViewHeight
            
            self.segmentedControlView.frame = CGRect(x: CGRectGetMinX(self.segmentedControlView.frame), y: CGRectGetMinY(self.segmentedControlView.frame) + segmentedControlYAnimation, width: CGRectGetWidth(self.segmentedControlView.frame), height: CGRectGetHeight(self.segmentedControlView.frame))
        })
        
        isScrollingDown = !isScrollingDown
    }

}
