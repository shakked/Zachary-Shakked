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

class ZSSHomeViewController: UIViewController, UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate {

    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var itemBehavior : UIDynamicItemBehavior!
    var colors : [UIColor]!
    var balls : [ZSSBall] = []
    
    let motionManager : CMMotionManager = CMMotionManager()
    let queue : NSOperationQueue = NSOperationQueue()
    let lastUpdateTime : NSDate = NSDate()
    
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
    
    var i : Int = 0
    var welcomeView : WelcomeView!
    var coffeeImageView : UIImageView!
    
    var collisionItemsToRemove : [UIDynamicItem] = []
    var viewCenters : [String: CGPoint]! = ["test" : CGPointMake(0, 0)]
    
    var isFirstTimeViewing : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimators()
        configureViews()
        changeColorScheme("Goldfish")
        showBalls()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureMotionManager()
        changeColorScheme("Goldfish")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        isFirstTimeViewing = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.motionManager.stopDeviceMotionUpdates()
    }
         
    func configureViews() -> Void {
        tempImageView = UIImageView(frame: self.view.frame)
        self.view.addSubview(tempImageView)
        configureTimers()
        configureCoffeeView()
    }
    
    func configureTimers() -> Void {

        let timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("configureWelcomeView"), userInfo: nil, repeats: false)

    }
    
    func tadaCoffee(timer: NSTimer) -> Void {
        coffeeImageView.tada { () -> Void in
        }
    }
    
    func configureCoffeeView() -> Void {
        coffeeImageView = UIImageView(image: UIImage(named: "Mug"))
        coffeeImageView.frame = CGRectMake(30, self.view.frame.size.height - 100, 70, 70)
        self.view.addSubview(coffeeImageView)
        coffeeImageView.backgroundColor = UIColor.whiteColor()
        coffeeImageView.layer.cornerRadius = 35
        coffeeImageView.layer.zPosition = 1
        coffeeImageView.layer.shadowColor = UIColor.grayColor().CGColor;
        coffeeImageView.layer.shadowOffset = CGSizeMake(0, 2);
        coffeeImageView.layer.shadowOpacity = 1;
        coffeeImageView.layer.shadowRadius = 4.0;
        coffeeImageView.clipsToBounds = false;
        
        viewCenters["coffeeImageView"] = coffeeImageView.center
        
        NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: Selector("tadaCoffee:"), userInfo: coffeeImageView, repeats: false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "coffeeImageViewTapped")
        tapGesture.numberOfTapsRequired = 1
        coffeeImageView.addGestureRecognizer(tapGesture)
        coffeeImageView.userInteractionEnabled = true
        
    }
    
    func coffeeImageViewTapped() -> Void {
        changeColorScheme("Coffee")
        launchCoffeeImageView()
        collapseWelcomeView()
    }
    
    func launchCoffeeImageView() -> Void {
        gravity.addItem(coffeeImageView)
        itemBehavior.addItem(coffeeImageView)
        itemBehavior.addLinearVelocity(CGPointMake(250, -1000), forItem: coffeeImageView)
        itemBehavior.addAngularVelocity(CGFloat(300), forItem: coffeeImageView)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "showCoffeeView", userInfo: nil, repeats: false)
    }
    
    func showCoffeeView() -> Void {
        let cvc = ZSSCoffeeViewController()
        presentViewController(cvc, animated: true, completion: nil)
    }
    
    func changeColorScheme(colorScheme: String) -> Void {
        if colorScheme == "Coffee" {
            self.colors = [UIColor(rgba: "#D5C1A9"), UIColor(rgba: "#866633"), UIColor(rgba: "#B18965"), UIColor(rgba: "#683520"), UIColor(rgba: "#442419")]
        } else if colorScheme == "Goldfish" {
           self.colors = [UIColor(rgba:"#66CDE2"),UIColor(rgba:"#A7DBDB"), UIColor(rgba: "#E0E4CC"), UIColor(rgba: "#F38630"), UIColor(rgba: "#FA6900")]
        }
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
        setWelcomeViewCenters()
    }
    
    func setWelcomeViewCenters() -> Void {
        viewCenters["welcomeView"] = welcomeView.center
        viewCenters["hLabel"] = welcomeView.hLabel.center
        viewCenters["eLabel"] = welcomeView.eLabel.center
        viewCenters["l1Label"] = welcomeView.l1Label.center
        viewCenters["l2Label"] = welcomeView.l2Label.center
        viewCenters["oLabel"] = welcomeView.oLabel.center
        viewCenters["periodLabel"] = welcomeView.periodLabel.center
        viewCenters["iLabel"] = welcomeView.iLabel.center
        viewCenters["amLabel"] = welcomeView.amLabel.center
        viewCenters["zacharyLabel"] = welcomeView.zacharyLabel.center
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
        collision.collisionDelegate = self

        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.9
        itemBehavior.friction = 0
        
        itemBehavior.allowsRotation = false
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(itemBehavior)

    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {

        if p.y + 5 >= self.view.frame.size.height {
            collisionItemsToRemove.append(item)
        }
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying) {
        for item in collisionItemsToRemove {
            collision.removeItem(item)
        }
        collisionItemsToRemove = []
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
            if i % 3 == 0 {
                for ball in self.balls {
                    self.drawLineFrom(ball.lastPoint, toPoint: ball.center, color: ball.backgroundColor!, brushWidth: ball.radius * 2)
                    ball.lastPoint = ball.center
                    if (ball.center.x < -10 || ball.center.x > self.view.frame.size.width + 20 || ball.center.y > self.view.frame.size.height + 10) {
                        self.balls.removeObject(ball)
                        self.gravity.removeItem(ball)
                        self.itemBehavior.removeItem(ball)
                        ball.removeFromSuperview()
                    }
                }
                
                if self.balls.count <= 0 {
                    self.showBalls()
                }
            }
            i++

        }
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

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
