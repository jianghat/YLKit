//
//  UIImage+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/25.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import Foundation
import CoreImage

extension UIImage {
    //    根据图片名称在bundle中搜索该图片
    class func imageFromBundle(_ name:String) -> UIImage! {
        let path = Bundle.main.path(forResource: name, ofType: nil);
        if path != nil {
            return UIImage(contentsOfFile: path!)!;
        } else {
            return UIImage(named: name)!
        }
    }
    
    //        根据color生成图片
    class func imageWithColor(_ color:UIColor) -> UIImage! {
        return self.imageWithColor(color, size: CGSize(width: 1, height: 1))
    }
    
    class func imageWithColor(_ color:UIColor, size: CGSize) -> UIImage! {
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorImage!
    }
    
    //        view快照
    class func imageWithView(_ view: UIView) -> UIImage {
        let size: CGSize  = view.bounds.size
        //参数1:表示区域大小 参数2:如果需要显示半透明效果,需要传NO,否则传YES 参数3:屏幕密度
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //  改变图片的color
    func imageWithTintColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1, y: -1)
        context.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    //  图片圆角
    func roundImage(size:CGFloat, radius:CGFloat) -> UIImage {
        return self.roundImage(size: size, radius: radius, borderWidth:0, borderColor: .clear)
    }
    
    func roundImage(size:CGFloat, radius:CGFloat, borderWidth:CGFloat?, borderColor:UIColor?) -> UIImage {
        let scale = self.size.width / size
        var width: CGFloat =  0
        var color: UIColor = .clear
        
        if let borderWidth = borderWidth {
            width = borderWidth * scale
        }
        
        if let borderColor = borderColor {
            color = borderColor
        }
        
        let radius = radius * scale
        let react = CGRect(x: width, y: width, width: self.size.width - 2 * width, height: self.size.height - 2 * width)
        
        //绘制图片设置
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let path = UIBezierPath(roundedRect:react, cornerRadius: radius)
        //绘制边框
        path.lineWidth = width
        color.setStroke()
        path.stroke()
        path.addClip()
        
        //画图片
        draw(in: react)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //  重设图片大小
    func reSizeImage(reSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        self.draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    func scaleImage(_ scaleSize:CGFloat) -> UIImage {
        let reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height * scaleSize);
        return reSizeImage(reSize: reSize)
    }
    
    //图片压缩到几兆之内
    func compressionToSize(_ size: CGFloat) -> Data {
        var imageData:Data = self.jpegData(compressionQuality: 1)!
        var rate:CGFloat = 1
        while(CGFloat(imageData.count) > size * 1000) {
            rate -= 0.1
            imageData = self.jpegData(compressionQuality: rate)!
            if(rate<=0.19) {
                break;
            }
        }
        return imageData;
    }
    
    /**
     *  识别图片二维码
     *  @returns: 二维码内容
     */
    func recognizeQRCode() -> String? {
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyHigh])
        let features = detector?.features(in: CoreImage.CIImage(cgImage: self.cgImage!))
        guard (features?.count)! > 0 else { return nil }
        let feature = features?.first as? CIQRCodeFeature
        return feature?.messageString
    }
}
