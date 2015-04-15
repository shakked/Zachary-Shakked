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
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        layer.cornerRadius = rect.width / 2.0
        layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        radius = frame.width / 2.0;
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supporter")
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
