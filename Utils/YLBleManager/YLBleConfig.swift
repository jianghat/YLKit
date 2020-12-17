//
//  YLBleConfig.swift
//  Driver
//
//  Created by ym on 2020/12/2.
//

import UIKit

class YLBleConfig: NSObject {
    //是否启用日志，默认未启用
    public static var enableLog: Bool = false
    
    //限定扫描到设备的名字
    public static var acceptableDeviceNames: [String]?
    
    //限定可发现的设备serviceUUIDs
    public static var acceptableDeviceServiceUUIDs: [String]?
}
