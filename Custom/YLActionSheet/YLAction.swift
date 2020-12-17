//
//  YLAction.swift
//  Driver
//
//  Created by ym on 2020/10/7.
//

import Foundation
 
typealias YLActionHandler = (YLAction) -> Void

class YLAction: NSObject {
    var title: String?
    var handler: YLActionHandler?
    
    override init() {
        super.init()
    }
    
    convenience init(title: String, action: @escaping YLActionHandler) {
        self.init()
        self.title = title
        self.handler = action
    }
}
