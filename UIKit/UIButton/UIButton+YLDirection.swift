//
//  UIButton+YLDirection.swift
//  Driver
//
//  Created by ym on 2020/10/12.
//

import Foundation

extension UIButton {
    /**  设置按钮里 图片&文字 之间的间隔 */
    func setLeftImageAndTextPadding(_ padding: CGFloat) {
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: padding/2.0, bottom: 0, right: -padding/2.0)
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding/2.0, bottom: 0, right: padding/2.0)
        
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    /**  改变图片 & 文字方向(左文字右图片)  */
    func setRightImageAndTextPadding(_ padding: CGFloat) {
        let image: UIImage! = self.image(for: .normal) ?? UIImage()
        let buttonLabelS = (self.titleLabel?.text ?? "").sizeWithFont(self.titleLabel?.font, constrainedToWidth: CGFloat.greatestFiniteMagnitude)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -image.size.width-padding, bottom: 0, right: image.size.width+padding)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: buttonLabelS.width+padding, bottom: 0, right: -buttonLabelS.width-padding)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }

    /**  上图片下文字  */
    func setTopImageAndTextPadding(_ padding: CGFloat) {
        // 获取文字Size & 图片Size
        let textSize: CGSize! = self.titleLabel?.text?.sizeWithFont(self.titleLabel?.font, constrainedToWidth: CGFloat.greatestFiniteMagnitude)
        var titleSize: CGSize = textSize
        
        
        let frameSize = CGSize(width: textSize.width, height:textSize.height);
        if (titleSize.width + 0.5 < frameSize.width) {
            titleSize.width = frameSize.width
        }
        let imageSize = self.imageView!.image!.size
        
        // 判断宽度
        let maxWidth = max(imageSize.width, titleSize.width)
        let currWidth = imageSize.width + titleSize.width
        let diffWidth = currWidth - maxWidth
        
        // 判断高度
        let totalHeight = (imageSize.height + titleSize.height + padding)
        let currHeight = max(imageSize.height, titleSize.height)
        let diffHeight = totalHeight-currHeight
        
        // 获取位移
        var imageTop: CGFloat = 0
        var imageWidth: CGFloat = 0
        var labelTop: CGFloat = 0
        var labelWidth: CGFloat = 0
        // 纵向(暂时没考虑 文字高度>图片高度)
        if (imageSize.height>titleSize.height) {
            imageTop = diffHeight/2.0;
            labelTop = (-titleSize.height+imageSize.height+diffHeight)/2.0;
        }
        // 横向
        if (imageSize.width>titleSize.width) {
            imageWidth = diffWidth/2.0;
            labelWidth = (diffWidth+imageSize.width-titleSize.width)/2.0;
        } else {
            imageWidth = diffWidth/2.0+titleSize.width/2.0-imageSize.width/2.0;
            labelWidth = diffWidth/2.0;
        }
        
        self.titleEdgeInsets = UIEdgeInsets(top: labelTop, left: -labelWidth, bottom: -labelTop, right: labelWidth)
        
        self.imageEdgeInsets = UIEdgeInsets(top: -imageTop, left: imageWidth, bottom: imageTop, right: -imageWidth)
        
        self.contentEdgeInsets = UIEdgeInsets(top: padding*2, left: -diffWidth/2.0, bottom: padding*2, right: -diffWidth/2.0)
    }
    
    /**  添加垂直间隙  */
    func addContentVerticalPadding(_ padding: CGFloat) {
        self.addContentVerticalTopPadding(padding)
        self.addContentVerticalBottomPadding(padding)
    }
    
    func addContentVerticalTopPadding(_ padding: CGFloat) {
        var tempInsets = self.contentEdgeInsets
        tempInsets.top += padding
        self.contentEdgeInsets = tempInsets
    }
    
    func addContentVerticalBottomPadding(_ padding: CGFloat) {
        var tempInsets = self.contentEdgeInsets
        tempInsets.bottom += padding
        self.contentEdgeInsets = tempInsets;
    }
    
    /**  添加水平间隙  */
    func addContentHorizontalPadding(_ padding: CGFloat) {
        var tempInsets = self.contentEdgeInsets
        tempInsets.left += padding
        tempInsets.right += padding
        self.contentEdgeInsets = tempInsets
    }
}
