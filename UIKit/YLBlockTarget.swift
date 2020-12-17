//
//  YLBlockTarget.swift
//  Driver
//
//  Created by ym on 2020/10/12.
//

import UIKit

typealias YLKitButtonItemBlock = (_ sender: Any) -> Void

class YLKitBlockTarget : NSObject {
    var block: YLKitButtonItemBlock?;
    
    override init() {
        super.init()
    }
    
    convenience init(block: @escaping YLKitButtonItemBlock) {
        self.init()
        self.block = block
    }
    
   @objc func invoke(_ sender: Any) {
        if block != nil {
            block!(sender)
        }
    }
}
