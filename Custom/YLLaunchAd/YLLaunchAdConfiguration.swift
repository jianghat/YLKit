//
//  YLLaunchAdConfiguration.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit
import AVFoundation

/** 显示完成动画类型 */
enum YLShowFinishAnimate {
    case None /** 无动画 */
    case Fadein /** 普通淡入(default) */
    case Lite /** 放大淡入 */
    case FlipFromLeft /** 左右翻转(类似网易云音乐) */
    case FlipFromBottom /** 下上翻转 */
    case CurlUp /** 向上翻页 */
}

class YLLaunchAdConfiguration: NSObject {
    /** 停留时间(default 5 ,单位:秒) */
    var duration: Int = 5

    /** 跳过按钮类型(default SkipTypeTimeText) */
    var skipButtonType: YLSkipType = .TimeText

    /** 显示完成动画(default ShowFinishAnimateFadein) */
    var showFinishAnimate: YLShowFinishAnimate = .Fadein

    /** 显示完成动画时间(default 0.8 , 单位:秒) */
    var showFinishAnimateTime: CGFloat = 0.8

    /** 设置开屏广告的frame(default UIScreen.main.bounds) */
    var frame: CGRect = UIScreen.main.bounds

    /** 程序从后台恢复时,是否需要展示广告(defailt false) */
    var showEnterForeground: Bool = false
    
    /** 点击打开页面参数 */
    var openModel: Any?

    /** 自定义跳过按钮(若定义此视图,将会自定替换系统跳过按钮) */
    var customSkipView: UIView?

    /** 子视图(若定义此属性,这些视图将会被自动添加在广告视图上,frame相对于window) */
    var subViews: [UIView]?
}


class YLLaunchImageAdConfiguration: YLLaunchAdConfiguration {
    /** image本地图片名(jpg/gif图片请带上扩展名)或网络图片URL string */
    var imageNameOrURLString: String?

    /** 图片广告缩放模式(default UIViewContentModeScaleToFill) */
    var contentMode: UIView.ContentMode = .scaleToFill

    /** 设置GIF动图是否只循环播放一次(YES:只播放一次,NO:循环播放,default NO,仅对动图设置有效) */
    var GIFImageCycleOnce: Bool = false
    
    func defaultConfiguration() -> YLLaunchImageAdConfiguration {
        //配置广告数据
        let configuration = YLLaunchImageAdConfiguration.init();
        //广告停留时间
        configuration.duration = 5;
        //广告frame
        configuration.frame = UIScreen.main.bounds;
        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
        configuration.GIFImageCycleOnce = false;
        //缓存机制
//        configuration.imageOption = XHLaunchAdImageDefault;
        //广告显示完成动画
        configuration.showFinishAnimate = .Fadein;
        //后台返回时,是否显示广告
        configuration.showEnterForeground = false;
        return configuration;
    }
}

class YLLaunchVideoAdConfiguration: YLLaunchAdConfiguration {
    /** video本地名或网络链接URL string */
    var videoNameOrURLString: String?

    /** 视频缩放模式(default AVLayerVideoGravityResizeAspectFill) */
    var videoGravity: AVLayerVideoGravity = .resizeAspectFill

    /** 设置视频是否只循环播放一次(YES:只播放一次,NO循环播放,default NO) */
    var videoCycleOnce: Bool = false

    /** 是否关闭音频(default NO) */
    var muted: Bool = false

    class func defaultConfiguration() -> YLLaunchVideoAdConfiguration {
        //配置广告数据
        let configuration = YLLaunchVideoAdConfiguration.init()
        //广告停留时间
        configuration.duration = 5;
        //广告frame
        configuration.frame = UIScreen.main.bounds;
        //是否只循环播放一次
        configuration.videoCycleOnce = false;
        //广告显示完成动画
        configuration.showFinishAnimate = .Fadein;
        //显示完成动画时间
        configuration.showFinishAnimateTime = 0.8;
        //跳过按钮类型
        configuration.skipButtonType = .TimeText;
        //后台返回时,是否显示广告
        configuration.showEnterForeground = false;
        //是否静音播放
        configuration.muted = false;
        return configuration;
    }
}
