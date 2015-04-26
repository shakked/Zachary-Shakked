//
//  ZSSPixableViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/25/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSPixableViewController: ZSSInfoViewController {

    var footballImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViews() {
        super.configureViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tellMeMoreButtonPressed() {
        let pmvc = ZSSPixableMoreViewController()
        UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.view.alpha = 0.0
            }) { (completed: Bool) -> Void in
                self.presentViewController(pmvc, animated: false, completion: nil)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        
    }
}
