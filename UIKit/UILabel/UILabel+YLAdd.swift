//
//  UILabel+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import UIKit

extension UILabel {
    class func label(font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = font
        label.textColor = textColor
        return label
    }
    
    class func label(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        return label
    }
    
    func expectedWidth() -> CGFloat {
        self.numberOfLines = 1;
        let text: NSString = self.text! as NSString;
        let size = text.size(withAttributes: [NSAttributedString.Key.font : self.font!]);
        return size.width;
    }
}
