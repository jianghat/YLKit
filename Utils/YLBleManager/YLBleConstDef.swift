//
//  YLBleConstDef.swift
//  Driver
//
//  Created by ym on 2020/12/2.
//

import Foundation

let defaultScanTimeoutInterval = 60.0
let defaultConnectTimeoutInterval = 60.0

func debug_log(_ msg: String) {
    if YLBleConfig.enableLog {
        print(msg)
    }
}
