//
//  ZSSInfoViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/23/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSInfoViewController: UIViewController, UIScrollViewDelegate {
    
    var width : CGFloat!
    var height : CGFloat!
    
    init() {
        super.init(nibName: "ZSSInfoViewController", bundle: NSBundle.mainBundle())
        addScrollViewAndLabels()
        addImageView()
        configureAnimator()
        configureViews()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var scrollView : UIScrollView!
    var titleLabel : UILabel!
    var label1 : UILabel!
    var label2 : UILabel!
    var backgroundImageView : UIImageView!
    var zachIconImageView : UIImageView!
    var subject : ZSSSubject!
    var nextSubjectButton : UIButton!
    var nextSubjectButtonSmall : UIButton!
    
    
    var isAnimatingDismissal : Bool = false
    var isAnimatingTransition : Bool = false
    var userDidScrollRight : Bool = false
    
    var animator : UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var gravity : UIGravityBehavior!
    var dynamics : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func addScrollViewAndLabels() -> Void {
        width = self.view.frame.size.width
        height = self.view.frame.size.height
        
        scrollView = UIScrollView(frame: CGRectMake(8, 86, width - 16, height - 94 ))
        scrollView.contentSize = CGSizeMake((2 * width) - 16, height - 94)
        self.view.addSubview(scrollView)
        
        titleLabel = UILabel(frame: CGRectMake(8, 8, width - 16, 70))
        self.view.addSubview(titleLabel)
        
        let scrollViewHeight = scrollView.frame.size.height
        label1 = UILabel(frame: CGRectMake(8, 0, width - 16, scrollViewHeight))
        label2 = UILabel(frame: CGRectMake(label1.frame.size.width + 24, 0, width - 16, scrollViewHeight))
        
        scrollView.addSubview(label1)
        scrollView.addSubview(label2)
        scrollView.delegate = self
    }
    
    func addImageView() -> Void {
        backgroundImageView = UIImageView(frame: CGRectMake(-200, 0, self.view.frame.size.width * 3, self.view.frame.size.height))
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backgroundImageView)
        
        zachIconImageView = UIImageView(frame: CGRectMake(150, (height / 2.0) - 40, 80, 80))
        zachIconImageView.image = UIImage(named: "ZachIcon")
        zachIconImageView.layer.zPosition = 1
        zachIconImageView.alpha = 0.0
        self.backgroundImageView.addSubview(zachIconImageView)
        
        nextSubjectButton = UIButton(frame: CGRectMake(self.scrollView.contentSize.width, (height/2.0) - 35, 70, 70))
        nextSubjectButton.layer.zPosition = 1
        nextSubjectButton.alpha = 0.0
        nextSubjectButton.layer.cornerRadius = 35.0
        self.backgroundImageView.addSubview(nextSubjectButton)
    }
    
    func configureAnimator() -> Void {
        self.animator = UIDynamicAnimator(referenceView: self.view)
        self.gravity = UIGravityBehavior()
        
        self.collision = UICollisionBehavior()
        self.collision.addBoundaryWithIdentifier("nextSubjectButton", fromPoint: CGPointMake(0, height - 25), toPoint: CGPointMake(width, height - 25))
        
        self.dynamics = UIDynamicItemBehavior()
        self.dynamics.elasticity = 0.5
        self.dynamics.allowsRotation = true
        
        self.animator.addBehavior(self.gravity)
        self.animator.addBehavior(self.collision)
        self.animator.addBehavior(self.dynamics)
    }

    
    func configureViews() -> Void {
        titleLabel.font = UIFont(name: "Avenir-Light", size: 48.0)
        titleLabel.numberOfLines = 1
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.layer.zPosition = 1
        titleLabel.layer.shadowOffset = CGSizeMake(1,1)
        titleLabel.layer.shadowColor = UIColor.blackColor().CGColor
        titleLabel.layer.masksToBounds = false
        titleLabel.layer.shadowOpacity = 1.0
        
        label1.font = UIFont(name: "Avenir-Light", size: 22.0)
        label1.numberOfLines = 0
        label1.textColor = UIColor.whiteColor()
        label1.layer.zPosition = 1
        label1.layer.shadowOffset = CGSizeMake(2,2)
        label1.layer.shadowColor = UIColor.blackColor().CGColor
        label1.layer.masksToBounds = false
        label1.layer.shadowOpacity = 1.0
        
        label2.font = UIFont(name: "Avenir-Light", size: 22.0)
        label2.numberOfLines = 0
        label2.textColor = UIColor.whiteColor()
        label2.layer.zPosition = 1
        label2.layer.shadowOffset = CGSizeMake(2,2)
        label2.layer.shadowColor = UIColor.blackColor().CGColor
        label2.layer.masksToBounds = false
        label2.layer.shadowOpacity = 1.0

        scrollView.layer.zPosition = 1
        
        configureBackButton()
        configureNextSubjectButtonSmall()
    }
    
    func configureBackButton() -> Void {
        let backButton = UIButton(frame: CGRectMake(15, height - 75, 50, 50))
        backButton.setImage(UIImage(named: "ZachIcon"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "fadeAndDismissView", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton:", userInfo: backButton, repeats: true)
    }
    
    func configureNextSubjectButtonSmall() -> Void {
        nextSubjectButtonSmall = UIButton(frame: CGRectMake(width - 60, height - 100, 50, 50))
        nextSubjectButtonSmall.addTarget(self, action: "scrollRightAndShowNextSubjectButton", forControlEvents: .TouchUpInside)
        nextSubjectButtonSmall.layer.cornerRadius = 25
        self.view.addSubview(nextSubjectButtonSmall)

        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "bounceNextSubject:", userInfo: nil, repeats: true)
        
        self.gravity.addItem(nextSubjectButtonSmall)
        self.dynamics.addItem(nextSubjectButtonSmall)
        self.collision.addItem(nextSubjectButtonSmall)
    }
    
    func bounceNextSubject(timer: NSTimer) -> Void {
        if !self.userDidScrollRight {
            self.gravity.removeItem(nextSubjectButtonSmall)
            self.dynamics.removeItem(nextSubjectButtonSmall)
            self.collision.removeItem(nextSubjectButtonSmall)
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.nextSubjectButtonSmall.frame = CGRectMake(self.width - 60, self.height - 100, 50, 50)
            })
            NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "addBackToGravity", userInfo: nil, repeats: false)
            
        } else {
            timer.invalidate()
        }
    }
    
    func addBackToGravity() -> Void {
        self.gravity.addItem(nextSubjectButtonSmall)
        self.dynamics.addItem(nextSubjectButtonSmall)
        self.collision.addItem(nextSubjectButtonSmall)
    }
    
    func scrollRightAndShowNextSubjectButton() -> Void {
        self.dynamics.addAngularVelocity(9.0, forItem: self.nextSubjectButtonSmall)
        self.scrollView.setContentOffset(CGPointMake(425,0), animated: true)
    }
    
    func showNextSubject() -> Void {
        
    }
    
    func rotateBackButton(timer: NSTimer) -> Void {
        let backButton = timer.userInfo! as! UIButton
        runSpinAnimationOnce(backButton, duration: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.view.alpha = 0.0
        configureSubject()
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.view.alpha = 1.0
        })
    }
    
    func configureSubject() -> Void {
        self.backgroundImageView.image = self.subject.backgroundImage
        self.titleLabel.text = self.subject.titleText
        self.label1.text = self.subject.label1Text
        self.label2.text = self.subject.label2Text
        self.nextSubjectButton.setImage(self.subject.nextSubject.iconImage, forState: UIControlState.Normal)
        self.nextSubjectButton.backgroundColor = self.subject.nextSubject.backgroundColor
        self.nextSubjectButtonSmall.setImage(self.subject.nextSubject.iconImage, forState: UIControlState.Normal)
        self.nextSubjectButtonSmall.backgroundColor = self.subject.nextSubject.backgroundColor
        self.label1.sizeToFit()
        self.label2.sizeToFit()


    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let imageFrame = self.backgroundImageView.frame
        let newFrame = CGRectMake(-200 - (0.5 * scrollView.contentOffset.x ), 0, imageFrame.size.width, imageFrame.size.height)
        self.backgroundImageView.frame = newFrame
        
        let x = scrollView.contentOffset.x
        if x < 0 && x > -100 {
            self.zachIconImageView.alpha = -0.01 * x % 100
            self.zachIconImageView.layer.transform = CATransform3DMakeRotation(0.02 * x % 100, 0, 0.0, 1.0);
        }
        
        if self.zachIconImageView.alpha > 0.800 && !self.isAnimatingDismissal {
            self.isAnimatingDismissal = true
            runSpinAnimation(self.zachIconImageView,duration: 1.5)
            fadeAndDismissView()
        }
        
        let xPastScreen = x - self.view.frame.size.width
        if xPastScreen > 0 {
            let alpha = 0.01 * xPastScreen
            self.nextSubjectButton.alpha = alpha
            self.nextSubjectButton.layer.transform = CATransform3DMakeRotation(-1.57 + (0.02 * x % 100), 0, 0.0, 1.0);
        }
        
        if self.nextSubjectButton.alpha > 0.800 && !self.isAnimatingTransition {
            self.isAnimatingTransition = true
            runSpinAnimation(self.nextSubjectButton, duration: 1.5)
            fadeAndTransition()
        }

        if x > 50 {
            self.userDidScrollRight = true
        }
    }
    
    func runSpinAnimation(view: UIView, duration: CGFloat) -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_PI * 2.0))
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 5.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func runSpinAnimationOnce(view: UIView, duration: CGFloat) -> Void {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(float: Float(M_PI * 2.0))
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.cumulative = true
        rotationAnimation.repeatCount = 1.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        view.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func fadeAndDismissView() -> Void {
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (completed: Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func fadeAndTransition() -> Void {
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (completed: Bool) -> Void in
                let civ = ZSSInfoViewController()
                civ.subject = self.subject.nextSubject
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    UIApplication.sharedApplication().keyWindow!.rootViewController!.view.alpha = 0.0
                    UIApplication.sharedApplication().keyWindow!.rootViewController!.presentViewController(civ, animated: false, completion: nil)
                })
        })
        
    }
    
    func showNextView() -> Void {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
