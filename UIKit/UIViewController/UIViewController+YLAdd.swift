//
//  UIViewController+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/30.
//

import UIKit

enum YLItemPosition {
    case rightItem
    case leftItem
}

extension UIViewController {
    class func currentViewController (base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController! {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
    
    func currentViewController () -> UIViewController! {
        if let nav = self as? UINavigationController {
            return nav.visibleViewController?.currentViewController()
        }
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.currentViewController()
        }
        if let presented = self.presentedViewController {
            return presented.currentViewController()
        }
        return self
    }
    
    /*
     *  @brief  导航栏标题
     *
     *  @param title        标题
     */
    func setNavigationTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    /*
     *  @brief  显示导航栏左边视图图片
     *
     *  @param imageName        图片or名称
     *  @param actionBlock      回调函数
     *
     *  @return UIButton
     */
    @discardableResult
    func setLeftBarButtonItem(imageName: Any, actionBlock: @escaping YLKitButtonItemBlock) -> UIButton {
        return setLeftBarButtonItem(imageName: imageName, highlightedName: imageName, actionBlock: actionBlock)
    }
    
    @discardableResult
    func setLeftBarButtonItem(imageName: Any, highlightedName: Any?, actionBlock: @escaping YLKitButtonItemBlock) -> UIButton {
        let button: UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: YLNavItemWidth, height: YLNavHeight));
        if imageName is UIImage {
            button.setImage(imageName as? UIImage, for: UIControl.State.normal)
        } else {
            button.setImage(YLImageNamed(imageName as! String), for: UIControl.State.normal)
        }
        
        if highlightedName is UIImage {
            button.setImage(highlightedName as? UIImage, for: UIControl.State.highlighted)
        } else {
            button.setImage(YLImageNamed(highlightedName as! String), for: UIControl.State.highlighted)
        }
        
        button.setBlockFor(UIControl.Event.touchUpInside) { (sender: Any) in
            let btn: UIButton = sender as! UIButton
            actionBlock(btn);
        }
        self.navigationItem.setLeftBarButton(UIBarButtonItem.init(customView: button), animated: false)
        return button;
    }
    
    /*
     *  @brief  显示导航栏左边视图图片
     *
     *  @param imageName        图片or名称
     *  @param actionBlock      回调函数
     *
     *  @return UIButton
     */
    @discardableResult
    func setRightBarButtonItem(imageName: Any, actionBlock: @escaping YLKitButtonItemBlock) -> UIButton {
        return setRightBarButtonItem(imageName: imageName, highlightedName: imageName, actionBlock: actionBlock)
    }
    
    @discardableResult
    func setRightBarButtonItem(imageName: Any, highlightedName: Any?, actionBlock:@escaping YLKitButtonItemBlock) -> UIButton {
        let button: UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: YLNavItemWidth, height: YLNavHeight));
        if imageName is UIImage {
            button.setImage(imageName as? UIImage, for: UIControl.State.normal)
        } else {
            button.setImage(YLImageNamed(imageName as! String), for: UIControl.State.normal)
        }
        
        if highlightedName is UIImage {
            button.setImage(highlightedName as? UIImage, for: UIControl.State.highlighted)
        } else {
            button.setImage(YLImageNamed(highlightedName as! String), for: UIControl.State.highlighted)
        }
        button.setBlockFor(UIControl.Event.touchUpInside) { (sender: Any) in
            let btn: UIButton = sender as! UIButton
            actionBlock(btn);
        }
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: button), animated: false)
        return button;
    }
    
    @discardableResult
    func setNavigationBarButtonItem(_ title: String?, color: UIColor?, imageName: String?, position: YLItemPosition, actionBlock:@escaping YLKitButtonItemBlock) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: YLNavHeight))
        button.setBlockFor(UIControl.Event.touchUpInside) { (sender: Any) in
            let btn: UIButton = sender as! UIButton
            actionBlock(btn);
        }
        button.contentHorizontalAlignment = .center;
        button.setTitleOfNormal(title ?? "");
        button.setTitleOfHighlighted(title ?? "");
        button.setColorOfNormal(color ?? UIColor.white);
        button.setFontOfSize(size: 15);
        
        if (imageName != nil){
            button.setImageOfNormal(imageName: imageName!);
            button.setImageOfHighlighted(imageName: imageName!);
        }
        
        let titleSize: CGSize = (button.titleLabel?.intrinsicContentSize)!;
        let imageSize: CGSize = (button.imageView?.frame.size)!;
        let space: CGFloat = 1.0;
        
        button.width = max(titleSize.width + imageSize.width + space, YLNavItemWidth);
        
        if (imageName != nil && title != nil) {
            button.imageEdgeInsets = UIEdgeInsets.init(top: -titleSize.height, left: 0, bottom: 0, right: -titleSize.width);
            button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: -imageSize.height-space, right: 0);
        }
        
        if position == .leftItem {
            self.navigationItem.setLeftBarButton(UIBarButtonItem.init(customView: button), animated: false)
        } else {
            self.navigationItem.setRightBarButton(UIBarButtonItem.init(customView: button), animated: false)
        }
        return button;
    }
    
    /*
     *  @brief  显示导航栏左边文字
     *
     *  @param title            名称
     *  @param actionBlock      回调函数
     */
    func setLeftBarTitleItem(title: String, actionBlock:YLKitButtonItemBlock!) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButtonItem(title, actionBlock: actionBlock!)
    }
    
    /*
     *  @brief  显示导航栏右边文字
     *
     *  @param title            名称
     *  @param actionBlock      回调函数
     */
     func setRightBarTitleItem(title: String, actionBlock:YLKitButtonItemBlock!) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.barButtonItem(title, actionBlock: actionBlock)
    }
    
//    #MARK: Notification
    func yl_addNotifyObserver(selector: Selector, name: String, object: Any?) {
        YLNotificationCenter.yl_addObserver(self, selector: selector, name: name, object: object);
    }
    
    func yl_addNotifyObserver(_ observer: Any, selector: Selector, names: [String], object: Any?) {
        for name in names {
            self.yl_addNotifyObserver(selector: selector, name: name, object: object);
        }
    }
    
    func yl_postNotify(_ name: String, object: Any?) {
        YLNotificationCenter.yl_post(name, object: object);
    }
    
    func yl_removeNotify(_ name: String, object: Any?) -> Void {
        YLNotificationCenter.removeObserver(self, name: NSNotification.Name.init(name), object: object);
    }
    
    func yl_removeAllNotify() -> Void {
        YLNotificationCenter.removeObserver(self);
    }
}

