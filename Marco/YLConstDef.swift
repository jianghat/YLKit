//
//  YLConstDef.swift
//  Driver
//
//  Created by ym on 2020/9/25.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import UIKit
import AVFoundation

//数字
let YLNum: String = "0123456789";
//字母
let YLAlpha: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//数字和字母
let YLAlphaNum: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

typealias YLVoidOneArgumentBlock = (Any)->Void

let YLApplictionShared = UIApplication.shared;
let YLAppDelegate = YLApplictionShared.delegate as! AppDelegate;
let YLKeyWindow = YLApplictionShared.keyWindow!
let YLNotificationCenter = Foundation.NotificationCenter.default;
let YLUserDefaults = Foundation.UserDefaults.standard;
let YLMainBundle = Bundle.main;

// MARK: Device
let YLCurrentDevice = UIDevice.current

let YLDeviceName: String = YLCurrentDevice.name;

let YLDeviceSystemName: String = YLCurrentDevice.systemName;

let YLDeviceVersion = (YLCurrentDevice.systemVersion as NSString).floatValue;

let YLDeviceModel: String = YLCurrentDevice.model;

let YLDeviceLanguage: String = Locale.preferredLanguages.first!;

let YLLocaleIdentifier: String = Locale.current.identifier;

let YL_IS_IPhoneX_All = UIDevice.isIPhoneXSeries()

let YLScreenBounds = UIScreen.main.bounds
let YLScreenSize = YLScreenBounds.size
let YLScreenWidth = YLScreenSize.width
let YLScreenHeight = YLScreenSize.height
let YLScale = UIScreen.main.scale

let YLNavItemWidth: CGFloat = 36
let YLNavHeight: CGFloat = 44
let YLNavBarHeight: CGFloat = (YL_IS_IPhoneX_All ? 88 : 64)
let YLTabbarHeight: CGFloat = (YL_IS_IPhoneX_All ? 83 : 49)
let YLStatusBarHeight: CGFloat = (YL_IS_IPhoneX_All ? 40 : 20)
let YLSafeAreaTop: CGFloat = (YLStatusBarHeight+YLNavHeight)
let YLSafeAreaHeight: CGFloat = (YLScreenHeight-YLSafeAreaTop)
let YLSafeAreaHeightWithTabbar: CGFloat = (YLScreenHeight-YLSafeAreaTop-YLTabbarHeight)
//全面屏iPhoneTabBar额外的高度
let YLFullTabbarExtraHeight: CGFloat = (YL_IS_IPhoneX_All ? 34 : 0)

func YLNetworkActivityIndicator(_ animated: Bool) {
    YLApplictionShared.isNetworkActivityIndicatorVisible = animated
}

func YLAudioServicesPlayAlertSound(_ path: String!) {
    var systemSoundID:SystemSoundID = 0;
    AudioServicesCreateSystemSoundID(NSURL.fileURL(withPath: path!) as CFURL, &systemSoundID)
    AudioServicesPlayAlertSound(SystemSoundID(systemSoundID));
}

// MARK: FONT

func kArialFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

// MARK: COLOR

let YLThemeBlueColor = UIColor.colorWithHexString("1BC5E8")

// MARK: UIIMage

func YLImageNamed(_ imageName: String) -> UIImage {
    return UIImage.init(named: imageName) ?? UIImage()
}

func YLWebBrowserShow(title: String?, url: String!) {
    let browser = YLWebBrowserViewController.init()
    browser.loadWebPageWithURL(title: title ?? "", url: url)
    browser.hidesBottomBarWhenPushed = true
    ROOTVC.pushViewController(browser)
}

 func YLWebBrowserShow(title: String?, url: String!, currentVC: UIViewController) {
    let browser = YLWebBrowserViewController.init()
    browser.loadWebPageWithURL(title: title ?? "", url: url)
    browser.hidesBottomBarWhenPushed = true
    currentVC.navigationController?.pushViewController(browser, animated: true)
}
