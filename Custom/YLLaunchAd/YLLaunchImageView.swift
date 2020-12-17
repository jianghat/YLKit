//
//  YLLaunchImageView.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit

enum YLSourceType {
    case LaunchImage
    case LaunchScreen
}

class YLLaunchImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    
    convenience init(sourceType: YLSourceType) {
        self.init(frame: UIScreen.main.bounds)
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.white
        switch sourceType {
        case .LaunchImage:
            self.image = UIImage.imageFromLaunchImage()
        default:
            self.image = UIImage.imageFromLaunchScreen()
        }
    }
}

extension UIImageView {
    
}
