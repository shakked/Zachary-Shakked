//
//  ZSSSportsViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/25/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import Darwin

class ZSSSportsViewController: ZSSInfoViewController {

    var footballImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        super.configureViews()
        configureFootball()
    }
    
    func configureFootball() -> Void {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        let footballFrame = CGRectMake(100, height - 200, 75, 75)
        footballImageView = UIImageView(frame: footballFrame)
        footballImageView.image = UIImage(named: "Football")
        footballImageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.backgroundImageView.addSubview(footballImageView)
    }
    
    override func tellMeMoreButtonPressed() {
        let smvc = ZSSSportsMoreViewController()
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (completed: Bool) -> Void in
                self.presentViewController(smvc, animated: false, completion: nil)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let footBallFrame = self.footballImageView.frame
        let x = scrollView.contentOffset.x
        let newY : CGFloat = (-0.00111) * ((scrollView.contentOffset.x - 200) * (scrollView.contentOffset.x - 200)) + (0.3333 * (scrollView.contentOffset.x - 200)) + 200
        
        let derivativeY = 0.3333 - 0.00222 * x
        let radianAngle = atan(derivativeY)
        let angle = radianAngle * CGFloat(180 / M_PI)
        let rotation =  CATransform3DMakeRotation(-1 * radianAngle, 0.2, 0.8, 1.0);
        let newFrame = CGRectMake(100 + (1.7 * scrollView.contentOffset.x), (self.view.frame.size.height - 200) - newY, 75, 75)
        footballImageView.frame = newFrame
        footballImageView.layer.transform = rotation
        
    }


}
