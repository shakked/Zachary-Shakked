//
//  ZSSSchoolViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/25/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSSchoolViewController: ZSSInfoViewController {
    
    var foregroundImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func addImageView() {
        super.addImageView()
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        foregroundImageView = UIImageView(frame: CGRectMake(-200, height - 200, width * 3, 200))
        foregroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(foregroundImageView)
        foregroundImageView.image = UIImage(named: "NYCSunsetWater.png")
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        let x = scrollView.contentOffset.x
        
        let newFrame = CGRectMake(-200 - 0.7 * x, height - 200, width * 3, 200)
        foregroundImageView.frame = newFrame
    }
    
    override func tellMeMoreButtonPressed() {
        let svc = ZSSSchoolMoreViewController()
        UIView.animateWithDuration(0.5
            , animations: { () -> Void in
                self.view.alpha = 0.0
            }) { (completed: Bool) -> Void in
                self.presentViewController(svc, animated:false, completion: nil)
        }
    }
}
