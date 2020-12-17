//
//  UIImage+YLAppLaunch.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit

extension UIImage {
    class func imageFromLaunchImage() -> UIImage? {
        let imageP = self.launchImageWithType("Portrait")
        if imageP != nil {
            return imageP
        }
        
        let imageL = self.launchImageWithType("Landscape")
        if imageL != nil {
            return imageL
        }
        return nil
    }
    
    class func imageFromLaunchScreen() -> UIImage? {
        let UILaunchStoryboardName = YLInfoDictionary["UILaunchStoryboardName"]
        if(UILaunchStoryboardName == nil){
            print("从 LaunchScreen 中获取启动图失败!");
            return nil;
        }
        
        let LaunchScreenSb = UIStoryboard(name: UILaunchStoryboardName as! String, bundle: nil).instantiateInitialViewController()
        if LaunchScreenSb != nil {
            let view: UIView! = LaunchScreenSb?.view
            view.frame = UIScreen.main.bounds;
            return self.imageWithView(view);
        }
        print("从 LaunchScreen 中获取启动图失败!");
        return nil;
    }
    
    fileprivate class func launchImageWithType(_ type: String) -> UIImage? {
        let viewSize = UIScreen.main.bounds.size
        let viewOrientation: String = type
        var launchImageName: String?
        let imagesInfoArray = YLInfoDictionary["UILaunchImages"]
        for dict: Dictionary<String, Any> in imagesInfoArray as! Array {
            var imageSize: CGSize = NSCoder.cgSize(for: "UILaunchImageSize")
            let imageOrientation = dict["UILaunchImageOrientation"] as! String
            if viewOrientation == imageOrientation {
                if "Landscape" == imageOrientation {
                    imageSize = CGSize(width: imageSize.height, height: imageSize.width);
                }
                
                if imageSize.equalTo(viewSize) {
                    launchImageName = (dict["UILaunchImageName"] as! String)
                    let image = UIImage(named: launchImageName!)
                    return image
                }
            }
        }
        return nil
    }
}
