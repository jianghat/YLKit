//
//  YLBaseViewController.swift
//  Driver
//
//  Created by ym on 2020/9/25.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import UIKit

class YLBaseViewController: UIViewController {
    var isViewDidLoaded: Bool = false;
    //是否来自于认证页面
    var isPopToRoot: Bool = false;
    
    // Mark Lazy Load
    lazy var http: WebRequestHelper = {
        let http = WebRequestHelper()
        http.mydelegate = self
        return http
    }();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false;
        if self.navigationController?.viewControllers.count > 1 {
            self.setLeftBarButtonItem(imageName: "navgation_back_white") {[weak self] (e) in
                if (self?.isPopToRoot == true) {
                    self?.navigationController?.popToRootViewController(animated: true);
                } else {
                    self?.navigationController?.popViewController(animated: true);
                }
            }
        }
        self.isViewDidLoaded = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        let navigationBar = self.navigationController?.navigationBar;
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.barTintColor = UIHEPLER.mainColor;
        navigationBar?.setBackgroundImage(YLImageNamed("navgation_line.png"), for: .default);
        navigationBar?.shadowImage = YLImageNamed("navgation_line.png");
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public func pushViewController(_ vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func pushViewController(_ vc: UIViewController, animated: Bool) {
        vc.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    @objc public func popViewController() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}

extension YLBaseViewController: WebRequestDelegate {
    func requestDataComplete(_ response: AnyObject, tag: Int) {
        
    }
    
    func requestDataFailed(_ error: String, tag: Int) {
        
    }
}
