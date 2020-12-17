//
//  UIButton+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import Foundation

extension UIButton {
    class func button(title: String, bgColor: UIColor, font: CGFloat) -> UIButton {
        let button = UIButton.init()
        button.setTitleOfNormal(title)
        button.setFontOfSize(size: font)
        button.setBackgroundColorOfNormal(color: bgColor)
        return button
    }
    
    private struct YLUIButtonRuntimeKey {
        static let KEY_Action = UnsafeRawPointer(bitPattern: "buttonBlockKey".hashValue)!
    }
    
    private var blockTarget: YLKitBlockTarget? {
        get {
            return objc_getAssociatedObject(self, YLUIButtonRuntimeKey.KEY_Action) as? YLKitBlockTarget
        }
        set {
            objc_setAssociatedObject(self, YLUIButtonRuntimeKey.KEY_Action, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.addTarget(newValue, action: #selector(newValue?.invoke(_:)), for: .touchUpInside)
        }
    }
    
    func setActionTouchUpInside(_ touchUpInside: @escaping YLKitButtonItemBlock) {
        let target = YLKitBlockTarget.init(block: touchUpInside)
        self.blockTarget = target
    }

    /*
     *  @brief  设置字体大小
     *
     *  @param size 大小
     */
    func setFontOfSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
    }

    /*
     *  @brief  设置常规状态下文本内容
     *
     *  @param title 文本
     */
    func setTitleOfNormal(_ title: String) {
        self.setTitle(title, for: UIControl.State.normal)
    }

    /*
     *  @brief  设置高亮状态下文本内容
     *
     *  @param title 文本
     */
    func setTitleOfHighlighted(_ title: String) {
        self.setTitle(title, for: UIControl.State.highlighted)
    }

    /*
     *  @brief  设置Disabled状态下文本内容
     *
     *  @param title 文本
     */
    func setTitleOfDisabled(_ title: String) {
        self.setTitle(title, for: UIControl.State.disabled)
    }

    /*
     *  @brief  设置常规状态下文本颜色
     *
     *  @param color 颜色
     */
    func setColorOfNormal(_ color : UIColor) {
        self.setTitleColor(color, for: UIControl.State.normal)
    }

    /*
     *  @brief  设置选中状态下文本颜色
     *
     *  @param color 颜色
     */
    func setColorOfSelected(_ color : UIColor) {
        self.setTitleColor(color, for: UIControl.State.selected)
    }

    /*
     *  @brief  设置高亮状态下文本颜色
     *
     *  @param color 颜色
     */
    func setColorOfHighlighted(_ color : UIColor) {
        self.setTitleColor(color, for: UIControl.State.highlighted)
    }

    /*
     *  @brief  设置常规状态下图片内容
     *
     *  @param imageName 图片
     */
    func setImageOfNormal(imageName: String) {
        self.setImage(UIImage(named: imageName), for: UIControl.State.normal)
    }

    /*
     *  @brief  设置高亮状态下图片内容
     *
     *  @param imageName 图片
     */
    func setImageOfHighlighted(imageName: String) {
        self.setImage(UIImage(named: imageName), for: UIControl.State.highlighted)
    }

    /*
     *  @brief  设置选择状态下图片内容
     *
     *  @param imageName 图片
     */
    func setImageOfSelected(imageName: String) {
        self.setImage(UIImage(named: imageName), for: UIControl.State.selected)
    }

    /*
     *  @brief  设置常规状态下图片内容
     *
     *  @param imageName 图片
     */
    func setBackgroundImageOfNormal(imageName: String) {
        self.setBackgroundImage(UIImage(named: imageName), for: UIControl.State.normal)
    }

    /*
     *  @brief  设置高亮状态下图片内容
     *
     *  @param imageName 图片
     */
    func setBackgroundImageOfHighlighted(imageName: String) {
        self.setBackgroundImage(UIImage(named: imageName), for: UIControl.State.highlighted)
    }

    /*
     *  @brief  设置常规状态下背景颜色
     *
     *  @param color 颜色
     */
    func setBackgroundColorOfNormal(color: UIColor) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: UIControl.State.normal)
    }

    /*
     *  @brief  设置高亮状态下背景颜色
     *
     *  @param color 颜色
     */
    func setBackgroundColorOfHighlighted(color: UIColor) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: UIControl.State.highlighted)
    }
    
    /*
     *  @brief  设置选中状态下背景颜色
     *
     *  @param color 颜色
     */
    func setBackgroundColorOfSelected(color: UIColor) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: UIControl.State.selected)
    }

    /*
     *  @brief  设置Disabled状态下背景颜色
     *
     *  @param color 颜色
     */
    func setBackgroundColorOfDisabled(color: UIColor) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: UIControl.State.disabled)
    }
}
