//
//  YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/8.
//

import Foundation

extension NSMutableAttributedString {
    /*
     *  @brief  查找字符串
     */
    func rangeOfString(_ string: String) -> NSRange {
        let string = NSString(string:self.string)
        let range = string.range(of: string as String)
        if range.location != NSNotFound {
            return range;
        }
        return NSMakeRange(0, 0)
    }
    
    /*
     *  @brief  设置字符串字体颜色
     *
     *  @param foregroundColor 颜色
     */
    func setForegroundColor(_ foregroundColor: UIColor) -> Void {
        self.setForegroundColor(foregroundColor, string: self.string)
    }
    
    /*
     *  @brief  设置字符串字体颜色
     *
     *  @param foregroundColor 颜色
     *  @param string          需要改变颜色的字符串
     */
    func setForegroundColor(_ foregroundColor: UIColor, string: String) -> Void {
        self.addAttributes([.foregroundColor : foregroundColor], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串背景颜色
     *
     *  @param backgroundColor 颜色
     */
    func setBackgroundColor(_ backgroundColor: UIColor) -> Void {
        self.setBackgroundColor(backgroundColor, string: self.string)
    }
    
    /*
     *  @brief  设置字符串背景颜色
     *
     *  @param backgroundColor 颜色
     *  @param string          需要改变颜色的字符串
     */
    func setBackgroundColor(_ backgroundColor: UIColor, string: String) -> Void {
        self.addAttributes([.backgroundColor : backgroundColor], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串字体大小
     *
     *  @param size 字体大小
     */
    func setFontOfSize(_ size: CGFloat) -> Void {
        self.setFontOfSize(size, string: self.string)
    }
    
    /*!
     *  @author DT
     *
     *  @brief  设置字符串字体大小
     *
     *  @param size   字体大小
     *  @param string 需要改变大小的字符串
     */
    func setFontOfSize(_ size: CGFloat, string: String) -> Void {
        self.addAttributes([.font : UIFont.systemFont(ofSize: size)], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串字体
     *
     *  @param size 字体
     */
    func setFontAttributeName(_ font : UIFont) -> Void {
        self.setFontAttributeName(font, string: self.string)
    }
    
    /*
     *  @brief  设置字符串字体
     *
     *  @param size   字体
     *  @param string 需要改变大小的字符串
     */
    func setFontAttributeName(_ font : UIFont, string: String) -> Void {
        self.addAttributes([.font : font], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串间隔
     *
     *  @param kernOfSize 间隔大小
     */
    func setKernOfSize(_ kernOfSize: CGFloat) -> Void {
        self.setKernOfSize(kernOfSize, string: self.string)
    }
    
    /*
     *  @brief  设置字符串间隔
     *
     *  @param kernOfSize 间隔大小
     *  @param string     需要改变间隔距离的字符串
     */
    func setKernOfSize(_ kernOfSize: CGFloat, string: String) -> Void {
        self.addAttributes([.kern: (kernOfSize)], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串描边宽度(这样就能使文字空心)
     *
     *  @param strokeWidth 宽度
     */
    func setStrokeWidth(_ strokeWidth: CGFloat) -> Void {
        self.setStrokeWidth(strokeWidth, string: self.string)
    }
    
    /*
     *  @brief  设置字符串描边宽度(这样就能使文字空心)
     *
     *  @param strokeWidth 宽度
     *  @param string      需要改变宽度的字符串
     */
    func setStrokeWidth(_ strokeWidth: CGFloat, string: String) -> Void {
        self.addAttributes([.strokeWidth: (strokeWidth)], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串描边颜色
     *
     *  @param strokeColor 颜色
     */
    func setStrokeColor(_ strokeColor: UIColor) -> Void {
        self.setStrokeColor(strokeColor, string: self.string)
    }
    
    /*
     *  @brief  设置字符串描边颜色
     *
     *  @param strokeColor 颜色
     *  @param string      需要改变颜色的字符串
     */
    func setStrokeColor(_ strokeColor: UIColor, string: String) -> Void {
        self.addAttributes([.strokeColor: strokeColor], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置行距距离
     *
     *  @param lineSpacing 距离
     */
    func setLineSpacing(_ lineSpacing: CGFloat) -> Void {
        self.setLineSpacing(lineSpacing, string: self.string)
    }
    
    /*
     *  @brief  设置行距间隔
     *
     *  @param lineSpacing 间隔
     *  @param string      需要改变间隔的字符串
     */
    func setLineSpacing(_ lineSpacing: CGFloat, string: String) -> Void {
        //设置行之间的margin
        let pStyle = NSMutableParagraphStyle.init()
        pStyle.lineSpacing = lineSpacing;
        self.addAttributes([.paragraphStyle : pStyle], range: self.rangeOfString(self.string))
    }
    
    /*
     *  @brief  设置字符串倾斜度
     *
     *  @param obliqueness 倾斜度
     */
    func setObliqueness(_ obliqueness: CGFloat) -> Void {
        self.setObliqueness(obliqueness, string: self.string)
    }
    
    /*
     *  @brief  设置字符串倾斜度
     *
     *  @param obliqueness 倾斜度
     *  @param string      需要改变倾斜度的字符串
     */
    func setObliqueness(_ obliqueness: CGFloat, string: String) -> Void {
        self.addAttributes([.obliqueness : obliqueness], range: self.rangeOfString(self.string))
    }
    
    /*
     *  @brief  设置字符串跳转超链接
     *
     *  @param jumpUrl 超链接地址
     */
    func setJumpUrl(_ jumpUrl: String) -> Void {
        self.setJumpUrl(jumpUrl, string: self.string)
    }
    
    /*
     *  @brief  设置字符串跳转超链接
     *
     *  @param jumpUrl 超链接地址
     *  @param string  超链接的字符串
     */
    func setJumpUrl(_ jumpUrl: String, string: String) -> Void {
        self.addAttributes([.link : NSURL.init(string: jumpUrl) ?? ""], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串删除线
     */
    func setStrikethrough() -> Void {
        self.setStrikethrough(self.string)
    }
    
    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     */
    func setStrikethrough(_ string: String) -> Void {
        self.setStrikethrough(string, color: UIColor.black)
    }
    
    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     *  @param color  颜色
     */
    func setStrikethrough(_ string: String, color: UIColor) -> Void {
        self.setStrikethrough(string, color: UIColor.black, style: NSUnderlineStyle.single)
    }
    
    /*
     *  @brief  设置字符串删除线
     *
     *  @param string 需要删除线的字符串
     *  @param color  颜色
     *  @param style  删除线样式
     */
    func setStrikethrough(_ string: String, color: UIColor, style: NSUnderlineStyle) -> Void {
        self.addAttributes([.baselineOffset : 0], range: self.rangeOfString(string))
        
        self.addAttributes([.strikethroughColor : color], range: self.rangeOfString(string))
        
        self.addAttributes([.strikethroughStyle : style], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串下划线
     */
    func setUnderline() -> Void {
        self.setUnderline(self.string)
    }
    
    /*
     *  @brief  设置字符串下划线
     *
     *  @param string 需要下划线的字符串
     */
    func setUnderline(_ string: String) -> Void {
        self.setUnderline(self.string, color: UIColor.black)
    }
    
    /*
     *  @brief  设置字符串下划线
     *
     *  @param string 需要下划线的字符串
     *  @param color  颜色
     */
    func setUnderline(_ string: String, color: UIColor) -> Void {
        self.setUnderline(string, color: color,style: NSUnderlineStyle.single)
    }
    
    /*
     *  @brief  设置字符串下划线
     *
     *  @param string 需要下划线的字符串
     *  @param color  颜色
     *  @param style  下划线样式
     */
    func setUnderline(_ string: String, color: UIColor, style: NSUnderlineStyle) -> Void {
        self.addAttributes([.underlineStyle : style, .underlineColor: color], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串段落样式
     *
     *  @param paragraph 段落样式
     */
    func setParagraphStyle(_ paragraph: NSMutableParagraphStyle) -> Void {
        self.setParagraphStyle(paragraph, string: self.string)
    }
    
    /*
     *  @brief  设置字符串段落样式
     *
     *  @param paragraph 段落样式
     *  @param string    需要改变样式的字符串
     */
    func setParagraphStyle(_ paragraph: NSMutableParagraphStyle, string: String) -> Void {
        self.addAttributes([.paragraphStyle : paragraph], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  设置字符串阴影样式
     *
     *  @param shadow 阴影样式
     */
    func setShadow(_ shadow: NSShadow) -> Void {
        self.setShadow(shadow, string: self.string)
    }
    
    /*
     *  @brief  设置字符串阴影样式
     *
     *  @param shadow 阴影样式
     *  @param string 需要改变阴影的字符串
     */
    func setShadow(_ shadow: NSShadow, string: String) -> Void {
        self.addAttributes([.shadow : shadow], range: self.rangeOfString(string))
    }
    
    /*
     *  @brief  獲取高度
     *
     @param width 最大寬度
     @return CGSize
     */
    func boundingRectWithWidth(_ width: CGFloat) -> CGSize {
        let size = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil).size
        return size
    }
}

