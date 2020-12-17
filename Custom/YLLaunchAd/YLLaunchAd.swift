//
//  YLLaunchAd.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit

enum YLLaunchAdType {
    case Image
    case Video
}

var _sourceType: YLSourceType  = .LaunchImage

protocol YLLaunchAdDelegate {
    
}

class YLLaunchAd: NSObject {
    var delegate: YLLaunchAdDelegate?
    var launchAdType: YLLaunchAdType  = .Image
    var waitDataDuration: Int = 0
    var imageAdConfiguration: YLLaunchImageAdConfiguration?
    var videoAdConfiguration: YLLaunchVideoAdConfiguration?
    var skipButton: YLLaunchAdButton?
    var adVideoView: YLLaunchAdVideoView?
    var window: UIWindow?
    var waitDataTimer: DispatchSourceTimer?
    var skipTimer: DispatchSourceTimer?
    var detailPageShowing: Bool = false
    var clickPoint: CGPoint?
    
    private class var sharedInstance: YLLaunchAd {
        let instance = YLLaunchAd.init()
        return instance
    }
    
    /**
     设置你工程的启动页使用的是LaunchImage还是LaunchScreen(default:SourceTypeLaunchImage)
     注意:请在设置等待数据及配置广告数据前调用此方法
     @param sourceType sourceType
     */
    
    class func setLaunchSourceType(_ sourceType: YLSourceType) {
        _sourceType = sourceType
    }

    /**
     *  设置等待数据源时间(建议值:3)
     */
    class func setWaitDataDuration(_ waitDataDuration: Int) {
        let launchAd = YLLaunchAd.sharedInstance
        launchAd.waitDataDuration = waitDataDuration
    }

    /**
     *  图片开屏广告数据配置
     */
    class func imageAdWithImageAdConfiguration(_ imageAdconfiguration: YLLaunchImageAdConfiguration) -> YLLaunchAd {
        return YLLaunchAd.imageAdWithImageAdConfiguration(imageAdconfiguration, delegate: nil)
    }

    /**
     *  图片开屏广告数据配置
     *
     *  @param imageAdconfiguration 数据配置
     *  @param delegate             delegate
     *
     *  @return XHLaunchAd
     */
    class func imageAdWithImageAdConfiguration(_ imageAdconfiguration: YLLaunchImageAdConfiguration, delegate: YLLaunchAdDelegate?) -> YLLaunchAd {
        let launchAd = YLLaunchAd.sharedInstance
        if(delegate != nil) {
            launchAd.delegate = delegate
        }
        launchAd.imageAdConfiguration = imageAdconfiguration;
        return launchAd;
    }
    
    override init() {
        super.init()
        self.setupLaunchAd()
        YLNotificationCenter.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { (note) in
            
        }
        
        YLNotificationCenter.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { (note) in
            
        }
    }
    
    func setupLaunchAdEnterForeground() {
        switch self.launchAdType {
        case .Image:
            if !imageAdConfiguration!.showEnterForeground || detailPageShowing {
                return
            }
            self.setupLaunchAd()
            self.setupImageAdForConfiguration(imageAdConfiguration!)
        case .Video:
            if(!videoAdConfiguration!.showEnterForeground || detailPageShowing) {
                return
            }
            self.setupLaunchAd()
            self.setupVideoAdForConfiguration(videoAdConfiguration!)
        }
    }
    
    func setupLaunchAd() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window!.rootViewController = YLLaunchAdController.init()
        window!.rootViewController?.view.backgroundColor = UIColor.clear
        window!.rootViewController?.view.isUserInteractionEnabled = false
        window!.windowLevel = UIWindow.Level.statusBar + 1;
        window!.isHidden = false;
        window!.alpha = 1;
        /** 添加launchImageView */
        window?.addSubview(YLLaunchImageView(sourceType: _sourceType))
    }
    
    func setupImageAdForConfiguration(_ configuration: YLLaunchImageAdConfiguration) {
        if (self.window == nil) {
            return
        }
        self.removeSubViewsExceptLaunchAdImageView()
        let adImageView = YLLaunchImageView.init()
        adImageView.contentMode = configuration.contentMode
        self.window?.addSubview(adImageView)
        /** frame */
        if(configuration.frame.size.width>0 && configuration.frame.size.height>0) {
            adImageView.frame = configuration.frame
        }
    }
    
    func setupVideoAdForConfiguration(_ configuration: YLLaunchVideoAdConfiguration) {
        
    }
    
    func removeOnly () {
//        DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer)
//        DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer)
//        REMOVE_FROM_SUPERVIEW_SAFE(_skipButton)
//        if(_launchAdType==XHLaunchAdTypeVideo){
//            if(_adVideoView){
//                [_adVideoView stopVideoPlayer];
//                REMOVE_FROM_SUPERVIEW_SAFE(_adVideoView)
//            }
//        }
        if(self.window != nil) {
            let subviews = self.window?.subviews;
            for (_, view) in subviews!.enumerated() {
                
            }
            
//            [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                REMOVE_FROM_SUPERVIEW_SAFE(obj)
//            }];
            self.window!.isHidden = true;
            self.window = nil;
        }
    }

    func remove() {
        self.removeOnly()
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
//        if ([self.delegate respondsToSelector:@selector(xhLaunchShowFinish:)]) {
//            [self.delegate xhLaunchShowFinish:self];
//        }
//    #pragma clang diagnostic pop
//        if ([self.delegate respondsToSelector:@selector(xhLaunchAdShowFinish:)]) {
//            [self.delegate xhLaunchAdShowFinish:self];
//        }
    }

    func removeSubViewsExceptLaunchAdImageView() {
        for (_, view) in self.window!.subviews.enumerated() {
            if !view.isKind(of: YLLaunchImageView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
    deinit {
        YLNotificationCenter.removeObserver(self)
    }
}

