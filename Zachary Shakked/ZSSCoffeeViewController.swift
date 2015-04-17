//
//  ZSSCoffeeViewController.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/17/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ZSSCoffeeViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var iLabel: UILabel!
    @IBOutlet weak var loveLabel: UILabel!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var showMeTheLoveButton: UIButton!
    
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var iCollision : UICollisionBehavior!
    var loveCollision : UICollisionBehavior!
    var coffeeCollision : UICollisionBehavior!
    var chaosCollision : UICollisionBehavior!
    var dynamics : UIDynamicItemBehavior!
    
    var dropITimer : NSTimer!
    var dropLoveTimer : NSTimer!
    var dropCoffeeTimer : NSTimer!
    var tadaTimer : NSTimer!

    @IBOutlet weak var iBarrierView: UIView!
    @IBOutlet weak var loveBarrierView: UIView!
    @IBOutlet weak var coffeeBarrierView: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init() {
        super.init(nibName: "ZSSCoffeeViewController", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(animated: Bool) {
//        let iLabelFrame = iLabel.frame
//        let loveLabelFrame = loveLabel.frame
//        let coffeeLabelFrame = coffeeLabel.frame
//        let showMeTheLoveButtonFrame = showMeTheLoveButton.frame
//        
//        iLabel.frame = CGRectMake(iLabelFrame.origin.x, iLabelFrame.origin.y - 500, iLabelFrame.width, iLabelFrame.height)
//        loveLabel.frame = CGRectMake(loveLabelFrame.origin.x, loveLabelFrame.origin.y - 500, loveLabelFrame.width, loveLabelFrame.height)
//        coffeeLabel.frame = CGRectMake(coffeeLabelFrame.origin.x, coffeeLabelFrame.origin.y - 500, coffeeLabelFrame.width, coffeeLabelFrame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAnimators()
        configureViews()
        dropITimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "dropI", userInfo: nil, repeats: false)
        dropLoveTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "dropLove", userInfo: nil, repeats: false)
        dropCoffeeTimer = NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: "dropCoffee", userInfo: nil, repeats: false)
        tadaTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "tadaShowMeTheLoveButton", userInfo: nil, repeats: true)
    }
    
    func configureViews() -> Void {
        iLabel.layer.zPosition = 1
        loveLabel.layer.zPosition = 1
        coffeeLabel.layer.zPosition = 1
        showMeTheLoveButton.layer.zPosition = 1
        showMeTheLoveButton.layer.cornerRadius = 5
    }
    
    override func viewDidLayoutSubviews() {

    }
    
    
    func dropI() -> Void {
        dropITimer.invalidate()
        iCollision.addBoundaryWithIdentifier("iBoundary", forPath: UIBezierPath(rect: iBarrierView.frame))
        gravity.addItem(iLabel)
        iCollision.addItem(iLabel)
        println("droppingI withBoundaries\(iCollision.boundaryIdentifiers)")
    }
    
    func dropLove() -> Void {
        dropLoveTimer.invalidate()
        println("droppingLove withBoundaries\(loveCollision.boundaryIdentifiers)")
        loveCollision.addBoundaryWithIdentifier("loveBoundary", forPath: UIBezierPath(rect: loveBarrierView.frame))
        gravity.addItem(loveLabel)
        loveCollision.addItem(loveLabel)
    }
    
    func dropCoffee() -> Void {
        dropCoffeeTimer.invalidate()
        coffeeCollision.addBoundaryWithIdentifier("coffeeBoundary", forPath: UIBezierPath(rect: coffeeBarrierView.frame))
        gravity.addItem(coffeeLabel)
        coffeeCollision.addItem(coffeeLabel)
    }
    
    func tadaShowMeTheLoveButton() -> Void {
        showMeTheLoveButton.tada { () -> Void in
            
        }
    }
    
    func configureAnimators() -> Void {
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior()
        gravity.magnitude = 1.0
        
        iCollision = UICollisionBehavior()
        loveCollision = UICollisionBehavior()
        coffeeCollision = UICollisionBehavior()
        
        chaosCollision = UICollisionBehavior()
        chaosCollision.translatesReferenceBoundsIntoBoundary = true
        dynamics = UIDynamicItemBehavior()
        dynamics.elasticity = 0.9
        dynamics.allowsRotation = false
        
        animator.addBehavior(gravity)
        animator.addBehavior(iCollision)
        animator.addBehavior(loveCollision)
        animator.addBehavior(coffeeCollision)
        animator.addBehavior(chaosCollision)
        animator.addBehavior(dynamics)
        
    }
    
    
    
    @IBAction func showMeTheLoveButtonPressed(sender: AnyObject) {
        loadCoffeeLoveChaos()
    }
    
    func loadCoffeeLoveChaos() -> Void {
        playCoffeeNoises()
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "dropCoffeeMug", userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "dropHeart", userInfo: nil, repeats: true)
    }
    
    func dropCoffeeMug() -> Void {
        var coffeeLabel = UILabel(frame: CGRectMake(CGFloat(arc4random() % UInt32(self.view.frame.width)),35, 40, 40))
        coffeeLabel.text = "☕️"
        coffeeLabel.font = UIFont(name: "Avenir", size: 40.0)
        coffeeLabel.layer.zPosition = 1
        self.view.addSubview(coffeeLabel)
        
        gravity.addItem(coffeeLabel)
        dynamics.addItem(coffeeLabel)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "deleteCoffee:", userInfo: coffeeLabel, repeats: false)
    }
    
    func dropHeart() -> Void {
        var heartLabel = UILabel(frame: CGRectMake(CGFloat(arc4random() % UInt32(self.view.frame.width)), 35, 40, 40))
        heartLabel.text = "❤️"
        heartLabel.font = UIFont(name: "Avenir", size: 40.0)
        heartLabel.layer.zPosition = 1
        self.view.addSubview(heartLabel)
        
        gravity.addItem(heartLabel)
        dynamics.addItem(heartLabel)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "deleteHeart:", userInfo: heartLabel, repeats: false)
    }
    
    func deleteHeart(timer: NSTimer) -> Void {
        let heartLabel = timer.userInfo as! UILabel
        gravity.removeItem(heartLabel)
        dynamics.removeItem(heartLabel)
        heartLabel.removeFromSuperview()
    }
    
    func deleteCoffee(timer: NSTimer) -> Void {
        let coffeeLabel = timer.userInfo as! UILabel
        gravity.removeItem(coffeeLabel)
        dynamics.removeItem(coffeeLabel)
        coffeeLabel.removeFromSuperview()
    }
    
    func playCoffeeNoises() -> Void {
        
    }



}
