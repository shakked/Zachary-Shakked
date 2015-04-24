//
//  ZSSDraggableButton.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/23/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSDraggableButton: UIButton {

    var physicsEnabled : Bool = true
    
    var dynamics : UIDynamicItemBehavior?
    var collision : UICollisionBehavior?
    
    
    var lastPoint : CGPoint! //check if this is needed
    private var lastTouchLocation : CGPoint = CGPoint(x: 0.0, y: 0.0)
    private var lastTouchTime : NSDate = NSDate()
    private var currentTouchVelocity : CGPoint = CGPoint(x: 0.0, y: 0.0)

    func configurePhysics(dynamics: UIDynamicItemBehavior, collision: UICollisionBehavior) -> Void {
        self.dynamics = dynamics
        self.collision = collision
        enablePhysics()
    }
    
    func addVelocity(velocity: CGPoint) -> Void {
        dynamics?.addLinearVelocity(velocity, forItem: self)
    }
    
    func disablePhysics() -> Void {
        disableDynamics()
        disableCollision()
        physicsEnabled = false
    }
    
    func enablePhysics() -> Void {
        enableDynamics()
        enableCollision()
        physicsEnabled = true
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var theTouches = touches as NSSet
        let touch = theTouches.anyObject()! as! UITouch
        let touchLocation = touch.locationInView(self.superview)
        disablePhysics()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
            var theTouches = touches as NSSet
            let touch = theTouches.anyObject()! as! UITouch
            let touchLocation = touch.locationInView(self.superview!)
            self.center = touchLocation
        
        calculateAndSetTouchVelocity()
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        enablePhysics()
        addVelocity(currentTouchVelocity)
    }
    
    func calculateAndSetTouchVelocity() -> Void {
        let currentTouchLocation = self.center
        
        let xDistance = currentTouchLocation.x - lastTouchLocation.x
        let yDistance = currentTouchLocation.y - lastTouchLocation.y
        
        let timeSinceLastTouch = NSDate().timeIntervalSinceDate(lastTouchTime)
        
        let touchVelocityX = Double(xDistance) / Double(timeSinceLastTouch)
        let touchVelocityY = Double(yDistance) / Double(timeSinceLastTouch)
        currentTouchVelocity = CGPoint(x: touchVelocityX, y: touchVelocityY)
        lastTouchTime = NSDate()
        lastTouchLocation = currentTouchLocation
    }
}
