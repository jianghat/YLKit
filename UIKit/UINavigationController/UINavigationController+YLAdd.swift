//
//  UINavigationController+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/11/30.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        let viewController = self.visibleViewController;
        return viewController!.preferredStatusBarStyle;
    }
}

