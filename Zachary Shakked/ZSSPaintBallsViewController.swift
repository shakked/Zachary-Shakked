//
//  ZSSPaintBallsViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/20/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import Darwin
import CoreMotion

class ZSSPaintBallsViewController: UIViewController {
    
    private var gyroscopeEnabled = true
    private var ballsWillPaint = true
    private var animator : UIDynamicAnimator!
    private var gravity : UIGravityBehavior!
    private var dynamics : UIDynamicItemBehavior!
    private var collision : UICollisionBehavior!
    private var colors : [UIColor] = [UIColor(rgba:"#66CDE2"),UIColor(rgba:"#A7DBDB"), UIColor(rgba: "#E0E4CC"), UIColor(rgba: "#F38630"), UIColor(rgba: "#FA6900")]
    private var paintBalls : [ZSSBall] = []
    private var paintBallsToBeRelocated : [ZSSBall] = []
    private var paintCanvas : UIImageView!
    private var paintBallRadius : CGFloat = 35.0
    private var paintCanvasOpacity : CGFloat = 1.0
    let motionManager : CMMotionManager = CMMotionManager()
    let queue : NSOperationQueue = NSOperationQueue()
    let lastUpdateTime : NSDate = NSDate()
    
    private var timeOfLastDraw : NSDate = NSDate()
    var timeBetweenDraws : NSTimeInterval = 1/75.0
    var paintBallCenters : [CGPoint] = []
    var i : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimators()
        createPaintBalls()
        configureViews()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configureMotionManager()
    }
    
    override func viewDidDisappear(animated: Bool) {
        disableMotionManager()
    }
    
    func configureViews() -> Void {
        paintCanvas = UIImageView(frame: self.view.frame)
        self.view.addSubview(paintCanvas)
    }
    
    func resetPaintBallPositions() -> Void {
        self.paintBallsToBeRelocated = []
        println(self.paintBallsToBeRelocated)
        println("resetting position")
        for i in 0...(self.paintBalls.count - 1) {
            let center : CGPoint = self.paintBallCenters[i]
            let paintBall = self.paintBalls[i]
            paintBall.gravity!.removeItem(paintBall)
            dynamics.removeItem(paintBall)
            paintBall.center = center
            paintBall.lastPoint = center
            
        }
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "addDynamicsToBalls", userInfo: nil, repeats: false)
    }
    
    func resetPaintBall(paintBall: ZSSBall) -> Void {
        paintBall.gravity!.removeItem(paintBall)
        dynamics.removeItem(paintBall)
        paintBall.center = paintBall.initialCenter
        paintBall.lastPoint = paintBall.initialCenter
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "addDynamicsToBall:", userInfo: paintBall, repeats: false)
    }
    
    func addDynamicsToBall(timer: NSTimer) -> Void {
        let paintBall : ZSSBall = timer.userInfo! as! ZSSBall
        paintBall.gravity!.addItem(paintBall)
        dynamics.addItem(paintBall)
    }
    
    func addDynamicsToBalls() -> Void {
        for paintBall in self.paintBalls {
            dynamics.addItem(paintBall)
            paintBall.gravity!.addItem(paintBall)
        }
    }
    
    func createPaintBalls() -> Void {
        var frameSixth : CGFloat = CGFloat(self.view.frame.size.width / 6)
        let frameSixthCentersX : [CGFloat] = [frameSixth, 2 * frameSixth, 3 * frameSixth, 4 * frameSixth, 5 * frameSixth, 6 * frameSixth]
        
        var i = 0
        var ball : ZSSBall
        while ( i <= 4) {
            let color = self.colors[i]
            let centerX = frameSixthCentersX[i]
            
            ball = ZSSBall(radius: frameSixth / 2, center: CGPointMake(centerX, -20), color: color)
            self.view.addSubview(ball)
            ball.configurePhysics(gravity: gravity, dynamics: dynamics, collision: collision)
            ball.disableCollision()
            self.paintBalls.append(ball)
            i++
            
        }
        
        gravity.action = { () -> (Void) in
            if i % 3 == 0 {
                for ball in self.paintBalls {
                    self.drawLineFrom(ball.lastPoint, toPoint: ball.center, color: ball.backgroundColor!, brushWidth: ball.radius * 2)
                    ball.lastPoint = ball.center
                    if (ball.center.x < -10 || ball.center.x > self.view.frame.size.width + 20 || ball.center.y > self.view.frame.size.height + 10) {
                        self.paintBalls.removeObject(ball)
                        self.gravity.removeItem(ball)
                        self.dynamics.removeItem(ball)
                        ball.removeFromSuperview()
                    }
                }
                if self.paintBalls.count <= 0 {
                    self.createPaintBalls()
                }
            }
            i++
        }
    }
    
    func configurePaintBallCenters() -> Void {
        let numberOfBalls = colors.count
        var frameDivision : CGFloat = CGFloat(self.view.frame.size.width / CGFloat(numberOfBalls))
        for index in 0...(numberOfBalls - 1){
            let unadjustedCenter = CGFloat(index) * frameDivision
            let adjustedCenter = unadjustedCenter + frameDivision / 2
            self.paintBallCenters.append(CGPointMake(adjustedCenter, -20))
        }
    }
    
    func shouldRelocatePaintBall(paintBall: ZSSBall) -> Bool {
        if (paintBall.center.x < -10 || paintBall.center.x > self.view.frame.size.width + 20 || paintBall.center.y > self.view.frame.size.height + 10) {
            return true
        } else {
            return false
        }
    }
    
    func enableGyroscope() -> Void {
        
    }
    
    func disableGyroscope() -> Void {
        
    }
    
    func enableBallsWillFall() -> Void {
        
    }
    
    func disableBallsWillFall() -> Void {
        
    }
    
    func enableBallsWillPaint() -> Void {
        
    }
    
    func disableBallsWillPaint() -> Void {
        
    }
    
    func setPaintBallColors(colors: [UIColor]) -> Void {
        if self.colors.count < 15 && self.colors.count > 0 {
            self.colors = colors
        }
    }
    
    func setPaintBallRadius(radius: CGFloat) -> Void {
        if radius > 0 && radius < self.view.frame.size.width {
            self.paintBallRadius = radius
        }
    }
    
    private func configureAnimators() -> Void {
        collision = UICollisionBehavior()
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        dynamics = UIDynamicItemBehavior()
        dynamics.elasticity = 0.9
        dynamics.friction = 0
        dynamics.allowsRotation = false
        animator.addBehavior(gravity)
        animator.addBehavior(dynamics)
    }
    
    
    private func configureMotionManager() -> Void {
        motionManager.accelerometerUpdateInterval = 1.0/120.0
        motionManager.startDeviceMotionUpdatesToQueue(queue) { (motion: CMDeviceMotion!, error: NSError!) -> Void in
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
    
    func disableMotionManager() -> Void {
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    func showPaintBalls() -> Void {
        
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint, color: UIColor, brushWidth: CGFloat) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        paintCanvas.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
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
        
        paintCanvas.image = UIGraphicsGetImageFromCurrentImageContext()
        paintCanvas.alpha = 1.0
        UIGraphicsEndImageContext()    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
