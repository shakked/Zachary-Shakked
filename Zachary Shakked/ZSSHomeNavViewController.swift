//
//  ZSSHomeNavViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/20/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSHomeNavViewController: ZSSPaintBallsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var schoolButton: UIButton!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var appsButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!
    @IBOutlet weak var pixableButton: UIButton!
    @IBOutlet weak var nycButton: UIButton!
    
    var buttons : [UIButton]!

    override func configureViews() {
        super.configureViews()
//        self.buttons.append(schoolButton)
//        self.buttons.append(coffeeButton)
//        self.buttons.append(appsButton)
//        self.buttons.append(sportsButton)
//        self.buttons.append(pixableButton)
//        self.buttons.append(nycButton)

        self.buttons = [schoolButton, coffeeButton, appsButton, sportsButton, pixableButton, nycButton]
        
        for button in self.buttons {
            button.transform = CGAffineTransformMakeScale(0.01, 0.01)
            button.layer.cornerRadius = 30
            button.layer.shadowColor = UIColor.blackColor().CGColor
            button.layer.shadowOffset = CGSizeMake(1, 1)
            button.layer.zPosition = 1
            button.layer.shadowOpacity = 1.0
        }
        
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "showButtons", userInfo: nil, repeats: false)
    }
    
    init() {
        super.init(nibName: "ZSSHomeNavViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func showButtons() -> Void {
        for button in self.buttons {
            UIView.animateWithDuration(2.0,
                delay: 0,
                usingSpringWithDamping: 0.20,
                initialSpringVelocity: 6.00,
                options: UIViewAnimationOptions.AllowUserInteraction,
                animations: {
                    button.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
    }
}
