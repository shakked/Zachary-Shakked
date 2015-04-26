//
//  ZSSSchoolMoreViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSSchoolMoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackButton()
        configureAnimations()
    }
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    init() {
        super.init(nibName: "ZSSSchoolMoreViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAnimations() -> Void {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "loadLabel1", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "loadLabel2", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "loadLabel3", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "loadLabel4", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: "loadLabel5", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: "loadLabel6", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(8.5, target: self, selector: "loadLabel7", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(10.5, target: self, selector: "loadLabel8", userInfo: nil, repeats: false)
    }
    
    func loadLabel1() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label1.alpha = 1.0
        })
    }
    
    func loadLabel2() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label2.alpha = 1.0
        })
    }
    
    func loadLabel3() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label3.alpha = 1.0
        })
    }
    
    func loadLabel4() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label4.alpha = 1.0
        })
    }
    
    func loadLabel5() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label5.alpha = 1.0
        })
    }
    
    func loadLabel6() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label6.alpha = 1.0
        })
    }
    
    func loadLabel7() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label7.alpha = 1.0
        })
    }
    
    func loadLabel8() -> Void {
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label8.alpha = 1.0
        })
    }
    
    

    func configureBackButton() -> Void {
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "rotateBackButton", userInfo: backButton, repeats: true)
    }
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissAndFadeView()
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
