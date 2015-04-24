//
//  ZSSBall.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/14/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSBall: UIView {
    var radius : CGFloat = 0;
    var physicsEnabled : Bool = true
    
    var gravity : UIGravityBehavior?
    var dynamics : UIDynamicItemBehavior?
    var collision : UICollisionBehavior?
    var initialCenter : CGPoint!
    
    private var lastTouchLocation : CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var lastTouchTime : NSDate = NSDate()

    var lastPoint : CGPoint!
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = rect.width / 2.0
        layer.masksToBounds = true
    }
    
    func addVelocity(velocity: CGPoint) -> Void {
        dynamics?.addLinearVelocity(velocity, forItem: self)
    }
    
    func disablePhysics() -> Void {
        disableGravity()
        disableDynamics()
        disableCollision()
        physicsEnabled = false
    }
    
    func enablePhysics() -> Void {
        enableGravity()
        enableDynamics()
        enableCollision()
        physicsEnabled = true
    }
    
    func enableGravity() -> Void {
        if let gravity = gravity {
            gravity.addItem(self)
        }
    }
    
    func disableGravity() -> Void {
        if let gravity = gravity {
            gravity.removeItem(self)
        }
    }
    
    func enableDynamics() -> Void {
        if let dynamics = dynamics {
            dynamics.addItem(self)
        }
    }
    
    func disableDynamics() -> Void {
        if let dynamics = dynamics {
            dynamics.removeItem(self)
        }
    }
    
    func enableCollision() -> Void {
        if let collision = collision {
            collision.addItem(self)
        }
    }
    
    func disableCollision() -> Void {
        if let collision = collision {
            collision.removeItem(self)
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        radius = frame.width / 2.0;
        lastPoint = self.center
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supporter")
    }
    
    func configurePhysics(#gravity: UIGravityBehavior, dynamics: UIDynamicItemBehavior, collision: UICollisionBehavior) -> Void {
        self.gravity = gravity
        self.dynamics = dynamics
        self.collision = collision
        enablePhysics()
    }
    
    convenience init(radius: CGFloat, center: CGPoint) {
        let x = center.x - radius
        let y = center.y - radius
        let frame = CGRectMake(x, y, 2 * radius, 2 * radius)
        self.init(frame: frame)
        self.radius = radius
    }
    
    convenience init(radius: CGFloat, center: CGPoint, color: UIColor) {
        let x = center.x - radius
        let y = center.y - radius
        let frame = CGRectMake(x, y, 2 * radius, 2 * radius)
        self.init(frame: frame)
        backgroundColor = color
        self.radius = radius
    }

    
    

}
