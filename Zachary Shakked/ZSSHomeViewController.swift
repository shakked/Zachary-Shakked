//
//  ZSSHomeViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/14/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import Darwin
import CoreMotion

class ZSSHomeViewController: UIViewController {

    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var itemBehavior : UIDynamicItemBehavior!
    var colors : [UIColor]!
    var balls : [ZSSBall] = []
    
    let motionManager : CMMotionManager = CMMotionManager()
    let queue : NSOperationQueue = NSOperationQueue()
    let lastUpdateTime : NSDate = NSDate()
    
    var greenBall : ZSSBall!
    var blueBall : ZSSBall!
    var gravityHasBlueBall = false
    
    var touchVelocityX : Float = 0.0
    var touchVelocityY : Float = 0.0
    var timeOfLastTouch = NSDate(timeIntervalSince1970: 0)
    var locationOfLastTouch = CGPoint(x: 10, y: 10)
    
    var tempImageView : UIImageView!
    var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 50.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimators()
        configureViews()
        showBalls()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureMotionManager()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func configureViews() -> Void {
        tempImageView = UIImageView(frame: self.view.frame)
        self.view.addSubview(tempImageView)
        configureColors()
    }
    
    func configureColors() -> Void {

        self.colors = [UIColor(rgba:"#66CDE2"),UIColor(rgba:"#A7DBDB"), UIColor(rgba: "#E0E4CC"), UIColor(rgba: "#F38630"), UIColor(rgba: "#FA6900")]
        
    }
    
    func configureMotionManager () -> Void {
        self.motionManager.accelerometerUpdateInterval = 1.0/120.0
        self.motionManager.startDeviceMotionUpdatesToQueue(queue) { (motion: CMDeviceMotion!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            }
            
            let x : CGFloat = CGFloat(motion.gravity.x)
            let y : CGFloat = CGFloat(motion.gravity.y)
            var gravityPoint = CGPointMake(x,y)
            
            let interfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
            
            if interfaceOrientation == UIInterfaceOrientation.LandscapeLeft {
                let t = gravityPoint.x
                gravityPoint.x = 0.0 - gravityPoint.y
                gravityPoint.y = t
                
            } else if interfaceOrientation == UIInterfaceOrientation.LandscapeRight {
                let t = gravityPoint.x
                gravityPoint.x = gravityPoint.y
                gravityPoint.y = 0.0 - t
                
            } else if interfaceOrientation == UIInterfaceOrientation.PortraitUpsideDown {
                gravityPoint.x *= -1
                gravityPoint.y *= -1
            }
            
            let gravityDirection = CGVectorMake(gravityPoint.x, 0 - gravityPoint.y)
            self.gravity.gravityDirection = gravityDirection
        }
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
    }
    
    func showBalls() -> Void {
        var ball : ZSSBall
        for color in self.colors {
            ball = ZSSBall(radius: 25, center: CGPointMake(CGFloat(20 + arc4random() % 280), CGFloat(20 + arc4random() % 550)), color: color)
            view.addSubview(ball)
            ball.configurePhysics(gravity: gravity, dynamics: itemBehavior, collision: collision)
            ball.gravity!.action = { () -> (Void) in
                for ball in self.balls {
                    self.drawLineFrom(ball.lastPoint, toPoint: ball.center, color: ball.backgroundColor!, brushWidth: ball.radius * 2)
                    ball.lastPoint = ball.center
                }
            }
            ball.interactivityEnabled = false
            self.balls.append(ball)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, brushWidth: CGFloat) {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        
        let colorConverted = CIColor(color: color)!
        
        let redComp = colorConverted.red()
        let greenComp = colorConverted.green()
        let blueComp = colorConverted.blue()
        let alphaComp = colorConverted.alpha()
        
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, redComp, greenComp, blueComp, 1.0)
        CGContextSetBlendMode(context, kCGBlendModeNormal)
        
        CGContextStrokePath(context)
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
