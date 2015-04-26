//
//  ZSSCoffeeInfoViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSCoffeeInfoViewController: ZSSInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tellMeMoreButtonPressed() {
        let coffeeMap = ZSSCoffeeViewController()
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (completion: Bool) -> Void in
                self.presentViewController(coffeeMap, animated: false, completion: nil)
        }
    }
    

}
