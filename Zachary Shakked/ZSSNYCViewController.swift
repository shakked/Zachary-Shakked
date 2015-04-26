//
//  ZSSNYCViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/25/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSNYCViewController: ZSSInfoViewController {
    
    var subwayImageView : UIImageView!
    var carImageView : UIImageView!
    var busImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func configureViews() {
        super.configureViews()
        configureSubway()
    }
    
    func configureSubway() -> Void {
        let subwayFrame = CGRectMake(0, height - 100, 220, 20)
        subwayImageView = UIImageView(frame: subwayFrame)
        subwayImageView.image = UIImage(named: "Subway")
        self.backgroundImageView.addSubview(subwayImageView)
    }
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        let x = scrollView.contentOffset.x

        let newSubwayFrame = CGRectMake(0 + (2 * x), height - 100, 220, 20)
        subwayImageView.frame = newSubwayFrame
    }
    
    override func tellMeMoreButtonPressed() {
        let nycmvc = ZSSNYCMoreViewController()
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (completed: Bool) -> Void in
                self.presentViewController(nycmvc, animated: false, completion: nil)
        }
    }

}
