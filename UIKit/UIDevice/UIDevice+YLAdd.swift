//
//  YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/12.
//

import UIKit

extension UIDevice {    
    class func isIPhoneXSeries() -> Bool {
        var iPhoneX:Bool = false
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return iPhoneX
        }
        // iPhone X以上设备iOS版本一定是11.0以上
        if #available(iOS 11.0, *) {
            if Double((UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!) > 0.0 {
                iPhoneX = true
            }
        }
        return iPhoneX
    }
}

