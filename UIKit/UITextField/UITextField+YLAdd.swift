//
//  UITextField+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

extension UITextField {
    func currentOffset() -> NSInteger {
        return self.offset(from: self.beginningOfDocument, to: self.selectedTextRange!.start);
    }
    
    func makeOffset(_ offset: NSInteger) {
        var currentOffset: NSInteger  = self.offset(from: self.endOfDocument, to: self.selectedTextRange!.end);
        currentOffset += offset;
        
        let newPos: UITextPosition = self.position(from: self.endOfDocument, offset: currentOffset)!;
        self.selectedTextRange = self.textRange(from: newPos, to: newPos);
    }
    
    func makeOffsetFromBeginning(_ offset: NSInteger) {
        // 先把光标移动到文首，然后再调用上面实现的偏移函数。
        let begin: UITextPosition = self.beginningOfDocument;
        let start: UITextPosition = self.position(from: begin, offset: 0)!;
        let range:UITextRange = self.textRange(from: start, to: start)!;
        self.selectedTextRange = range;
        self.makeOffset(offset);
    }
    
    func marginLeft(_ width: CGFloat) {
        if width <= 0  {
            return;
        }
        self.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
    }
    
    func marginRight(_ width: CGFloat) {
        if width <= 0  {
            return;
        }
        self.rightView = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
    }
}
