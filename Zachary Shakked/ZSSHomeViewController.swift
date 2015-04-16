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

class ZSSHomeViewController: UIViewController, UIDynamicAnimatorDelegate {

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
    
    var welcomeView : WelcomeView!
    
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
        configureTimers()
    }
    
    func configureTimers() -> Void {

        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("configureWelcomeView"), userInfo: nil, repeats: false)
        let timer2 = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("collapseWelcomeView"), userInfo: nil, repeats: false)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureColors() -> Void {
        self.colors = [UIColor(rgba:"#66CDE2"),UIColor(rgba:"#A7DBDB"), UIColor(rgba: "#E0E4CC"), UIColor(rgba: "#F38630"), UIColor(rgba: "#FA6900")]
    }
    
    func configureWelcomeView() -> Void {
        welcomeView = NSBundle.mainBundle().loadNibNamed("WelcomeView", owner: self, options: nil)[0] as! WelcomeView
        welcomeView.frame = CGRectMake(-300, 20, self.view.frame.size.width - 40, 200)
        welcomeView.layer.zPosition = 1
        welcomeView.layer.cornerRadius = 15
        
        


        self.view.addSubview(welcomeView)
        
        let snap = UISnapBehavior(item: welcomeView, snapToPoint: CGPointMake(welcomeView.center.x + 320, welcomeView.center.y))
        snap.damping = 1.0
        animator.addBehavior(snap)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("collapseWelcomeView"), userInfo: nil, repeats: false)
        
    }
    
    func collapseWelcomeView() -> Void {
        
        UIView.animateKeyframesWithDuration(1.0, delay: 0, options: nil, animations: { () -> Void in
            self.welcomeView.backgroundColor = UIColor.clearColor()
            }) { (completed: Bool) -> Void in
        
        }
        
        gravity.addItem(welcomeView.hLabel)
        gravity.addItem(welcomeView.eLabel)
        gravity.addItem(welcomeView.l1Label)
        gravity.addItem(welcomeView.l2Label)
        gravity.addItem(welcomeView.oLabel)
        gravity.addItem(welcomeView.periodLabel)
        gravity.addItem(welcomeView.iLabel)
        gravity.addItem(welcomeView.amLabel)
        gravity.addItem(welcomeView.zacharyLabel)
        collision.addItem(welcomeView.hLabel)
        collision.addItem(welcomeView.eLabel)
        collision.addItem(welcomeView.l1Label)
        collision.addItem(welcomeView.l2Label)
        collision.addItem(welcomeView.oLabel)
        collision.addItem(welcomeView.periodLabel)
        collision.addItem(welcomeView.iLabel)
        collision.addItem(welcomeView.amLabel)
        collision.addItem(welcomeView.zacharyLabel)
        itemBehavior.addItem(welcomeView.hLabel)
        itemBehavior.addItem(welcomeView.eLabel)
        itemBehavior.addItem(welcomeView.l1Label)
        itemBehavior.addItem(welcomeView.l2Label)
        itemBehavior.addItem(welcomeView.oLabel)
        itemBehavior.addItem(welcomeView.periodLabel)
        itemBehavior.addItem(welcomeView.iLabel)
        itemBehavior.addItem(welcomeView.amLabel)
        itemBehavior.addItem(welcomeView.zacharyLabel)
        
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
        animator.delegate = self
        
        gravity = UIGravityBehavior()
        gravity.magnitude = 0.0
        
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true

        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.9
        itemBehavior.friction = 0
        
        itemBehavior.allowsRotation = false
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(itemBehavior)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func showBalls() -> Void {
        var frameSixth : CGFloat = CGFloat(self.view.frame.size.width / 6)
        let frameSixthCentersX : [CGFloat] = [frameSixth, 2 * frameSixth, 3 * frameSixth, 4 * frameSixth, 5 * frameSixth, 6 * frameSixth]
        
        var i = 0
        var ball : ZSSBall
        while ( i <= 4) {
            let color = self.colors[i]
            let centerX = frameSixthCentersX[i]

            ball = ZSSBall(radius: frameSixth / 2, center: CGPointMake(centerX, -20), color: color)
            self.view.addSubview(ball)
            ball.configurePhysics(gravity: gravity, dynamics: itemBehavior, collision: collision)
            ball.disableCollision()
            self.balls.append(ball)
            i++
            
        }
        
        
        
        gravity.action = { () -> (Void) in
            for ball in self.balls {
                self.drawLineFrom(ball.lastPoint, toPoint: ball.center, color: ball.backgroundColor!, brushWidth: ball.radius * 2)
                ball.lastPoint = ball.center
                if (ball.center.x < -10 || ball.center.x > self.view.frame.size.width + 20 || ball.center.y > self.view.frame.size.height + 10) {
                    self.balls.removeObject(ball)
                    ball.removeFromSuperview()
                }
            }
            
            if self.balls.count <= 0 {
                self.showBalls()
            }

        }
        
        
        
        
//        for color in self.colors {
//            ball = ZSSBall(radius: framePadding, center: CGPointMake(CGFloat(20 + arc4random() % 280), CGFloat(-20)), color: color)
//            view.addSubview(ball)
//            ball.configurePhysics(gravity: gravity, dynamics: itemBehavior, collision: collision)
//            ball.disableCollision()
//            ball.gravity!.action = { () -> (Void) in
//                for ball in self.balls {
//                    self.drawLineFrom(ball.lastPoint, toPoint: ball.center, color: ball.backgroundColor!, brushWidth: ball.radius * 2)
//                    ball.lastPoint = ball.center
//                }
//            }
//            
//            let timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("removeBall:"), userInfo: ball, repeats: false)
//            
//            self.balls.append(ball)
//        }
    }
    
    func removeBall(timer: NSTimer) -> Void {
        let ball : ZSSBall = (timer.userInfo as? ZSSBall)!
        ball.removeFromSuperview()

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
    
    func loadTranslucense() -> Void {
        
    }
    
    

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
