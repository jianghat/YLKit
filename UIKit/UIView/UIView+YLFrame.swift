//
//  UIView+YLFrame.swift
//  Driver
//
//  Created by ym on 2020/10/7.
//

import UIKit

extension UIView {
    var left: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.x = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var top: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var right: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.x = newValue - newFrame.size.width;
            self.frame = newFrame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var bottom: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.origin.y = newValue - newFrame.size.height
            self.frame = newFrame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var width: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.width = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var newFrame = self.frame
            newFrame.size.height = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var size: CGSize {
        set {
            var newFrame = self.frame
            newFrame.size = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.size
        }
    }
    
    var origin: CGPoint {
        set {
            var newFrame = self.frame
            newFrame.origin = newValue
            self.frame = newFrame
        }
        get {
            return self.frame.origin
        }
    }
}
