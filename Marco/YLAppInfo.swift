//
//  YLAppInfo.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import UIKit

let YLInfoDictionary = Bundle.main.infoDictionary!

/* CFBundleDisplayName*/
let YLBundleDisplayName: String = YLInfoDictionary["CFBundleDisplayName"] as! String

/* 项目名称*/
let YLProjectName: String = YLInfoDictionary[kCFBundleExecutableKey as String] as! String

/* BundleName*/
let YLBundleName: String = YLInfoDictionary[kCFBundleNameKey as String] as! String

/* bundleIdentifier*/
let YLBundleIdentifier: String = Bundle.main.bundleIdentifier!

let YLBundleShortVersion: String = YLInfoDictionary["CFBundleShortVersionString"] as! String

let YLBundleVersion: String = YLInfoDictionary["CFBundleVersion"] as! String

class YLAppInfo: NSObject {
    class var shared : YLAppInfo {
        struct Static {
            static var instance : YLAppInfo?
            static var token : Int = 0
        }
        if (Static.instance == nil) {
            Static.instance = YLAppInfo()
        }
        return Static.instance!
    }
    
    //MARK:当前版本的app是否第一次使用
    class func currentAppVersionFirstLaunchStatus() -> Bool {
        let userDefaults = Foundation.UserDefaults.standard;
        let key = "\(YLBundleShortVersion)_FirstLoad";
        if userDefaults.bool(forKey: key) == false {
            return true;
        }
        return false;
    }
    
    class func setCurrentAppVersionFirstLaunchStatus(_ status: Bool) {
        let userDefaults = Foundation.UserDefaults.standard;
        let key = "\(YLBundleShortVersion)_FirstLoad";
        userDefaults.set(status, forKey: key)
    }
}
