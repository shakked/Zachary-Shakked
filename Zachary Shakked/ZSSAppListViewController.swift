//
//  ZSSAppListViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSAppListViewController: UIViewController {

    @IBOutlet weak var productivView: UIView!
    @IBOutlet weak var shakdView: UIView!
    @IBOutlet weak var shikShakView: UIView!
    @IBOutlet weak var usernameSearcherView: UIView!
    @IBOutlet weak var backButton: UIButton!

    var animator : UIDynamicAnimator!
    var dynamics : UIDynamicItemBehavior!
    var gravity : UIGravityBehavior!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimator()
        configureBackButton()
        productivView.layer.cornerRadius = 8.0
        shakdView.layer.cornerRadius = 8.0
        shikShakView.layer.cornerRadius = 8.0
        usernameSearcherView.layer.cornerRadius = 8.0
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.alpha = 0.0
    }
    override func viewDidAppear(animated: Bool) {

        UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.view.alpha = 1.0
            }) { (completed: Bool) -> Void in
        }
    }
    
    init() {
        super.init(nibName: "ZSSAppListViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAnimator() -> Void {
        animator = UIDynamicAnimator(referenceView: self.view)
        dynamics = UIDynamicItemBehavior()
        gravity = UIGravityBehavior()
        
        animator.addBehavior(dynamics)
        animator.addBehavior(gravity)
    }
    
    @IBAction func productivButtonPressed(sender: AnyObject) {
        let screenShots = [UIImage(named: "productiv1.png")!,UIImage(named: "productiv2.png")!,UIImage(named: "productiv3.png")!]
        let backgroundColor = UIColor(rgba: "#2DB977")
        let titleTexts = ["Create Tasks for the Things you Need to Do", "See Graphical Feedback on your Task Progress", "Create and Categorize your Tasks"]
        shootView(self.productivView)
        presentAppViewController(screenShots, backgroundColor: backgroundColor, titleTexts: titleTexts)
    }

    @IBAction func shakdButtonPressed(sender: AnyObject) {
        let screenShots = [UIImage(named: "Shakd1.png")!,UIImage(named: "Shakd2.png")!,UIImage(named: "Shakd3.png")!]
        let backgroundColor = UIColor(rgba: "#3B3B3B")
        let titleTexts = ["Type your Message, Select a Voice, Change the Pitch and Speed", "Send and Receive Text-to-Speech Messages with Friends", "Over 30 Different Voices!"]
        shootView(self.shakdView)
        presentAppViewController(screenShots, backgroundColor: backgroundColor, titleTexts: titleTexts)
    }
    
    @IBAction func shikShakButtonPressed(sender: AnyObject) {
        let screenShots = [UIImage(named: "ShikShak1.jpeg")!,UIImage(named: "ShikShak2.png")!,UIImage(named: "ShikShak3.png")!]
        let backgroundColor = UIColor(rgba: "#16A086")
        let titleTexts = ["Pick a Theme Color", "Listen to Local Text-to-Speech Posts from People Around You", "Share Your Thoughts through Text-to-Speech Messages"]
        shootView(shikShakView)
        presentAppViewController(screenShots, backgroundColor: backgroundColor, titleTexts: titleTexts)
    }
    
    @IBAction func usernameSearcherButtonPressed(sender: AnyObject) {
        let screenShots = [UIImage(named: "UsernameSearcher1.png")!,UIImage(named: "UsernameSearcher2.png")!,UIImage(named: "UsernameSearcher3.png")!]
        let backgroundColor = UIColor(rgba: "#297FB8")
        let titleTexts = ["See if Your Desired Username is Available on Many Networks at Once", "Choose from Over 60 Networks to Search On", "Unlock All Searchable Networks"]
        shootView(usernameSearcherView)
        presentAppViewController(screenShots, backgroundColor: backgroundColor, titleTexts: titleTexts)
    }
    
    func presentAppViewController(screenShots: [UIImage], backgroundColor: UIColor, titleTexts: [String]) -> Void {
        let pvc = ZSSAppViewController(nibName: "ZSSAppViewController", bundle: nil)
        pvc.screenShots = screenShots
        pvc.backgroundColor = backgroundColor
        pvc.titleTexts = titleTexts
        presentView(pvc)
    }
    
    func presentView(pvc: ZSSAppViewController) -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.view.alpha = 0.0
            }) { (completed: Bool) -> Void in
            self.presentViewController(pvc, animated: false, completion: nil)
        }
    }
    
    func shootView(view: UIView) -> Void {
        
    }
    
    func configureBackButton() -> Void {
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton", userInfo: backButton, repeats: true)
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissAndFadeView()
    }
    
    func dismissAndFadeView() -> Void {
        UIView.animateWithDuration(1.5, animations: { () -> Void in
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
