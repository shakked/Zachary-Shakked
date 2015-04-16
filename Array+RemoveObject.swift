//
//  Array+RemoveObject.swift
//  Zachary Shakked
//
//  Created by Zachary Shakked on 4/16/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if(index != nil) {
            self.removeAtIndex(index!)
        }
    }
}