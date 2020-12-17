//
//  UIAlertController+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/11/5.
//

import UIKit

extension UIAlertController {
    private struct YLAlertControllerAssociateKeys {
        static var blockTargetKey: Void?;
        static var visibleKey: Void?;
    }
    
    var tapIndexBlock: YLKitButtonItemBlock? {
        set {
            let target: YLKitBlockTarget = YLKitBlockTarget.init();
            target.block = newValue;
            objc_setAssociatedObject(self, &YLAlertControllerAssociateKeys.blockTargetKey, target, .OBJC_ASSOCIATION_RETAIN);
        }
        get {
            let target = objc_getAssociatedObject(self, &YLAlertControllerAssociateKeys.blockTargetKey) as? YLKitBlockTarget;
            return target?.block;
        }
    }
    
    var isVisible: Bool {
       set {
           objc_setAssociatedObject(self, &YLAlertControllerAssociateKeys.visibleKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
       }
       get {
           let target = objc_getAssociatedObject(self, &YLAlertControllerAssociateKeys.visibleKey) as? Bool;
           return target ?? false;
       }
   }
    
    class func actionSheet(_ title: String?, message: String?, cancelButtonTitle: String?, otherButtonTitles: [String]?) -> UIAlertController {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet);
        if cancelButtonTitle != nil {
            alertController.addAction(UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: {[weak alertController] (alertAction) in
                alertController?.isVisible = false;
            }));
        }
        if otherButtonTitles != nil && otherButtonTitles?.count > 0 {
            for (index, buttonTitle) in otherButtonTitles!.enumerated() {
                alertController.addAction(UIAlertAction.init(title: buttonTitle, style: .default, handler: { [weak alertController] (alertAction) in
                    alertController?.isVisible = false;
                    if alertController?.tapIndexBlock != nil {
                        alertController?.tapIndexBlock!(index);
                    }
                }));
            }
        }
        return alertController;
    }
    
    class func alertView(_ title: String?, message: String?, cancelButtonTitle: String?, otherButtonTitles: [String]?) -> UIAlertController {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert);
        if cancelButtonTitle != nil {
            alertController.addAction(UIAlertAction.init(title: cancelButtonTitle, style: .cancel, handler: {[weak alertController] (alertAction) in
                alertController?.isVisible = false;
            }));
        }
        if otherButtonTitles != nil && otherButtonTitles?.count > 0 {
            for (index, buttonTitle) in otherButtonTitles!.enumerated() {
                alertController.addAction(UIAlertAction.init(title: buttonTitle, style: .default, handler: {[weak alertController] (alertAction) in
                    alertController?.isVisible = false;
                    alertController?.dismiss(animated: true, completion: {
                        if alertController?.tapIndexBlock != nil {
                            alertController?.tapIndexBlock!(index);
                        }
                    })
                }));
            }
        }
        return alertController;
    }
    
    func show() {
        UIViewController.currentViewController()?.present(self, animated: true, completion: {
            self.isVisible = true;
        });
    }
    
    func show(in controller: UIViewController!) {
        controller.present(self, animated: true) {
            self.isVisible = true;
        };
    }
}
