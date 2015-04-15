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
        gravity.magnitude = 1.0
        
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
        
        blueBall = ZSSBall(radius: 25, center: CGPointMake(200, 200), color: UIColor.blueColor())

        view.addSubview(blueBall)
        
        
        blueBall.configurePhysics(gravity: gravity, dynamics: itemBehavior, collision: collision)
        
    }
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
