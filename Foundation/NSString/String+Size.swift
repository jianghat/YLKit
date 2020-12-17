//
//  NSString+Size.swift
//  Driver
//
//  Created by ym on 2020/9/28.
//

import Foundation

extension String {
    func heightForView(font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude));
        label.lineBreakMode = NSLineBreakMode.byWordWrapping;
        label.numberOfLines = 0
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    /**
     *  @brief 计算文字的高度
     *
     *  @param font  字体(默认为系统字体)
     *  @param width 约束宽度
     */
    func heightWithFont(_ font: UIFont?, constrainedToWidth: CGFloat) -> CGFloat {
        let textFont = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        let paragraph = NSMutableParagraphStyle.init();
        paragraph.lineBreakMode = .byWordWrapping;
        
        let size = CGSize(width: constrainedToWidth, height: CGFloat.greatestFiniteMagnitude)
        let textSize = self.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes:[.font: textFont, .paragraphStyle: paragraph], context: nil).size
        return ceil(textSize.width)
    }
    
    /**
     *  @brief 计算文字的宽度
     *
     *  @param font   字体(默认为系统字体)
     *  @param height 约束高度
     */
    func widthWithFont(_ font: UIFont?, constrainedToHeight: CGFloat) -> CGFloat {
        let textFont = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        let paragraph = NSMutableParagraphStyle.init();
        paragraph.lineBreakMode = .byWordWrapping;
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: constrainedToHeight)
        let textSize = self.boundingRect(with:size, options:[.usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes:[.font: textFont, .paragraphStyle: paragraph],
                                      context:nil).size;
        return ceil(textSize.width)
    }

    /**
     *  @brief 计算文字的大小
     *
     *  @param font  字体(默认为系统字体)
     *  @param width 约束宽度
     */
    func sizeWithFont(_ font: UIFont?, constrainedToWidth: CGFloat) -> CGSize {
        let textFont = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        let paragraph = NSMutableParagraphStyle.init();
        paragraph.lineBreakMode = .byWordWrapping;
        
        let size = CGSize(width: constrainedToWidth, height: CGFloat.greatestFiniteMagnitude)
        let textSize = self.boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes:[.font: textFont, .paragraphStyle: paragraph], context: nil)
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }

    /**
     *  @brief 计算文字的大小
     *
     *  @param font   字体(默认为系统字体)
     *  @param height 约束高度
     */
    func sizeWithFont(_ font: UIFont?, constrainedToHeight: CGFloat) -> CGSize {
        let textFont = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        let paragraph = NSMutableParagraphStyle.init();
        paragraph.lineBreakMode = .byWordWrapping;
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: constrainedToHeight)
        let textSize = self.boundingRect(with:size, options:[.usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes:[.font: textFont, .paragraphStyle: paragraph],
                                      context:nil);
        
        return CGSize(width: ceil(textSize.width), height: ceil(textSize.height))
    }
}
