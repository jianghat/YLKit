//
//  YLNavigationController.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import UIKit

class YLNavigationController: UINavigationController, UIGestureRecognizerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
