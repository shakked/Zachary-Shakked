//
//  ZSSSportsMoreViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSSportsMoreViewController: UIViewController {

    var height : CGFloat!
    var width : CGFloat!
    var scrollView : UIScrollView!
    var backButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.alpha = 0.0
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    func configureViews() -> Void {
        self.view.backgroundColor = UIColor(red: 21/255.0, green: 207/255.0, blue: 173/255.0, alpha: 1.0)
        configureScrollView()
        configureOtherViews()
        configureBackButton()
    }
    
    func configureScrollView() -> Void {
        self.height = self.view.frame.size.height
        self.width = self.view.frame.size.width
        self.scrollView = UIScrollView(frame: self.view.frame)
        self.view.addSubview(scrollView)
        scrollView.contentSize = CGSizeMake(width, height * 1.7)
    }
    
    func configureOtherViews() -> Void {
        let outsideDormLabel = UILabel(frame: CGRectMake(8, 8, width - 16, 200))
        outsideDormLabel.text = "Right outside my dorm, there's a beatuiful courtyard."
        outsideDormLabel.numberOfLines = 5
        outsideDormLabel.font = UIFont(name: "Avenir-light", size:40.0)
        outsideDormLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(outsideDormLabel)
        
        let pigskinImageView = UIImageView(frame: CGRectMake(0, 216, width, height))
        pigskinImageView.backgroundColor = UIColor.redColor()
        pigskinImageView.contentMode = .ScaleAspectFill
        pigskinImageView.image = UIImage(named: "pigskin.jpg")
        self.scrollView.addSubview(pigskinImageView)
        
        let weLoveLabel = UILabel(frame: CGRectMake(8, 224 + height, width - 16, 120))
        weLoveLabel.text = "We love to play football here."
        weLoveLabel.numberOfLines = 3
        weLoveLabel.font = UIFont(name: "Avenir-light", size:40.0)
        weLoveLabel.textColor = UIColor.whiteColor()
        self.scrollView.addSubview(weLoveLabel)
    }
    
    func configureBackButton() -> Void {
        backButton = UIButton(frame: CGRectMake(8, height - 58, 50, 50))
        backButton.setImage(UIImage(named: "ZachIcon"), forState:.Normal)
        backButton.layer.zPosition = 1
        backButton.addTarget(self, action: "dismissAndFadeView", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton", userInfo: backButton, repeats: true)
        
    }
    
    func dismissAndFadeView() -> Void {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (completed: Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func rotateBackButton() -> Void {
        runSpinAnimation(self.backButton, duration:1.0)
    }
    
    func runSpinAnimation(view: UIView, duration: CGFloat) -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_PI * 2.0))
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.cumulative = true
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }

}
