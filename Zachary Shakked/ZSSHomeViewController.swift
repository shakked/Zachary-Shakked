//
//  ZSSHomeViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/14/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import Darwin

class ZSSHomeViewController: UIViewController {

    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var itemBehavior : UIDynamicItemBehavior!
    var greenBall : ZSSBall!
    var blueBall : ZSSBall!
    var gravityHasBlueBall = false
    
    var touchVelocityX : Float = 0.0
    var touchVelocityY : Float = 0.0
    var timeOfLastTouch = NSDate(timeIntervalSince1970: 0)
    var locationOfLastTouch = CGPoint(x: 10, y: 10)
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimators()
        showBalls()
        // Do any additional setup after loading the view.
    }
    
    func configureAnimators() -> Void {
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        gravity.magnitude = 0.5
        
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.9
        itemBehavior.allowsRotation = false
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(itemBehavior)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showBalls() -> Void {
        greenBall = ZSSBall(radius: 10, center: CGPointMake(50, 50), color: UIColor.greenColor())
        blueBall = ZSSBall(radius: 25, center: CGPointMake(200, 200), color: UIColor.blueColor())
//        let pan = UIPanGestureRecognizer(target: self, action: Selector("panRecognized:"))
//        self.view.addGestureRecognizer(pan)
        
        blueBall.interactivityEnabled = true
        view.addSubview(greenBall)
        view.addSubview(blueBall)
        
        gravity.addItem(greenBall)
        gravity.addItem(blueBall)
        
        collision.addItem(greenBall)
        collision.addItem(blueBall)
        
        itemBehavior.addItem(greenBall)
        itemBehavior.addItem(blueBall)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var theTouches = touches as NSSet
        let touch = theTouches.anyObject()! as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        let blueBallFrame = blueBall.frame
        if blueBallFrame.contains(touchLocation) {
            gravity.removeItem(blueBall)
            collision.removeItem(blueBall)
            itemBehavior.removeItem( blueBall)
            gravityHasBlueBall = false
        }
    }
    
    func panRecognized(sender: UIPanGestureRecognizer) -> Void {
        
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var theTouches = touches as NSSet
        let touch = theTouches.anyObject()! as! UITouch
        let touchLocation = touch.locationInView(self.view)
        
        let lastTouchX = locationOfLastTouch.x
        let lastTouchY = locationOfLastTouch.y
        let currentTouchX = touchLocation.x
        let currentTouchY = touchLocation.y
        
        let xDistance = currentTouchX - lastTouchX
        let yDistance = currentTouchY - lastTouchY
        
        let xFloat = Float(xDistance)
        let yFloat = Float(yDistance)
 
        let timeSinceLastTouch = NSDate().timeIntervalSinceDate(timeOfLastTouch)
        let timeFloat : Float = Float(timeSinceLastTouch)
        
        touchVelocityX = xFloat / timeFloat
        touchVelocityY = yFloat / timeFloat
        timeOfLastTouch = NSDate()
        locationOfLastTouch = touchLocation
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if !gravityHasBlueBall {
            gravity.addItem(blueBall)
            collision.addItem(blueBall)
            itemBehavior.addItem(blueBall)
            itemBehavior.addLinearVelocity(CGPointMake(CGFloat(touchVelocityX), CGFloat(touchVelocityY)), forItem: blueBall)
            gravityHasBlueBall = true
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
