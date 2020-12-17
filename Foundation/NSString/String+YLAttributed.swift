//
//  String+YLAttributed.swift
//  Driver
//
//  Created by ym on 2020/10/8.
//

import Foundation

extension String {
    /*
     *  @brief  设置字符串字体大小
     *
     *  @param size 字体大小
     *
     *  @return NSMutableAttributedString
     */
    func setFontOfSize(_ size: CGFloat) -> NSMutableAttributedString {
        return self.setFontOfSize(size, string: self)
    }

    /*
     *  @brief  设置字符串字体大小
     *
     *  @param size   字体大小
     *  @param string 需要改变大小的字符串
     *
     *  @return NSMutableAttributedString
     */
    func setFontOfSize(_ size: CGFloat, string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: string)
        attributedString.setFontOfSize(size)
        return attributedString
    }
    
    /*
     *  @brief  设置字符串字体颜色
     *
     *  @param foregroundColor 颜色
     *
     *  @return NSMutableAttributedString
     */
    func setForegroundColor(_ foregroundColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.setForegroundColor(foregroundColor)
        return attributedString
    }

    /*
     *  @brief  设置字符串字体颜色
     *
     *  @param foregroundColor 颜色
     *  @param string          需要改变颜色的字符串
     *
     *  @return NSMutableAttributedString
     */
    func setForegroundColor(_ foregroundColor: UIColor, string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: string)
        attributedString.setForegroundColor(foregroundColor)
        return attributedString
    }

    /*
     *  @brief  显示html内容
     *
     *  @return NSMutableAttributedString
     */
    func setHTMLTextDocument() -> NSMutableAttributedString {
        return self.setHTMLTextDocument(self)
    }

    /*
     *  @brief  显示html内容
     *  @param string          需要显示html的字符串
     *
     *  @return NSMutableAttributedString
     */
    func setHTMLTextDocument(_ string: String) -> NSMutableAttributedString {
        let attrStr = try! NSMutableAttributedString.init(data: string.data(using: .unicode)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attrStr;
    }

    /*
     *  @brief  设置字符串删除线
     *
     *  @return NSMutableAttributedString
     */
    func setStrikethrough() -> NSMutableAttributedString {
        return self.setStrikethrough(self)
    }

    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     *
     *  @return NSMutableAttributedString
     */
    func setStrikethrough(_ string: String) -> NSMutableAttributedString {
        return self.setStrikethrough(string, color: UIColor.black)
    }

    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     *  @param color  颜色
     *
     *  @return NSMutableAttributedString
     */
    func setStrikethrough(_ string: String, color: UIColor) -> NSMutableAttributedString {
        return self.setStrikethrough(string, color: UIColor.black, style: NSUnderlineStyle.single)
    }

    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     *  @param color  颜色
     *  @param style  删除线样式
     *
     *  @return NSMutableAttributedString
     */
    func setStrikethrough(_ string: String, color: UIColor, style: NSUnderlineStyle) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.setStrikethrough(string, color: color, style: style)
        return attributedString
    }

}
