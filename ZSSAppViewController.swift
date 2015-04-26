//
//  ZSSAppViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/26/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSAppViewController: UIViewController, UIPageViewControllerDataSource {

    var pageController : UIPageViewController!
    var screenShots : [UIImage]! = []
    var backgroundColor : UIColor!
    var titleTexts : [String]! = []
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var iPhoneImageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageController.dataSource = self
        self.pageController.view.frame = self.view.bounds
        
        let initialViewController : ZSSAppChildViewController = self.viewControllerAtIndex(0)
        var viewControllers : [ZSSAppChildViewController] = [initialViewController]
        self.pageController.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        self.addChildViewController(self.pageController)
        self.view.addSubview(self.pageController.view)
        self.pageController.didMoveToParentViewController(self)
        
        self.view.bringSubviewToFront(self.iPhoneImageView)
        self.view.bringSubviewToFront(self.backButton)
        configureBackButton()
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
    
    
    func viewControllerAtIndex(index: Int) -> ZSSAppChildViewController {
        let childViewController = ZSSAppChildViewController(nibName: "ZSSAppChildViewController", bundle: nil)
        childViewController.index = index
        childViewController.screenShot = self.screenShots[index]
        childViewController.backgroundColor = backgroundColor
        childViewController.titleText = self.titleTexts[index]
        self.view.backgroundColor = backgroundColor
        return childViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ZSSAppChildViewController).index
        
        if index == 0 {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ZSSAppChildViewController).index
        
        index++
        if index == 3 {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
