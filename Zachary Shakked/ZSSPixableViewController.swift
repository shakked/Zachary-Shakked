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
        configureFootball()
    }
    
    func configureFootball() -> Void {
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        let footballFrame = CGRectMake(200, height - 200, 75, 38)
        footballImageView = UIImageView(frame: footballFrame)
        footballImageView.image = UIImage(named: "Football")
        self.backgroundImageView.addSubview(footballImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        
        
    }
}
