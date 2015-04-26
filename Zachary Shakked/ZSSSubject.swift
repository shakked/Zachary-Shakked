//
//  ZSSSubject.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/24/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import UIKit

class ZSSSubject: NSObject {
    var titleText : String!
    var label1Text : String!
    var label2Text : String!
    var backgroundImage : UIImage!
    var iconImage: UIImage!
    var nextSubject : ZSSSubject!
    var backgroundColor : UIColor!
    var presentSelf : (animated: Bool) -> Void = {(animated: Bool) in }
    var presentTellMeMore : (animated: Bool) -> Void = {(animated: Bool) in }
}

