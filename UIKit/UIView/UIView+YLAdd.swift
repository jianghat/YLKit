//
//  UIView+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import UIKit

extension UIView {
    var viewController: UIViewController? {
        get {
            for view in sequence(first: self.superview, next: {$0?.superview}) {
                if let responder = view?.next {
                    if responder.isKind(of: UIViewController.self) {
                        return responder as? UIViewController
                    }
                }
            }
            return nil
        }
    };
    
    // 倒计时
    @discardableResult
    class func startCountDown(_ timeOut: Int, runBlock: @escaping (Int) -> Void, finshBlock: @escaping () -> Void) -> DispatchSourceTimer {
        var timeout: Int = timeOut; //倒计时时间
        let timer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global());
        timer.schedule(deadline: .now(), repeating: .milliseconds(1000));
        timer.setEventHandler {
            timeout -= 1
            if timeout < 0 {
                timer.cancel();
                DispatchQueue.main.async {
                    finshBlock();
                }
                return;
            }
            DispatchQueue.main.async {
                runBlock(timeout);
            }
        }
        timer.resume();
        return timer;
    }
    
    @discardableResult
    func startCountDown(_ timeOut: Int, runBlock: @escaping (Int) -> Void, finshBlock: @escaping () -> Void)  -> DispatchSourceTimer {
        return UIView.startCountDown(timeOut, runBlock: runBlock, finshBlock: finshBlock);
    }
    
    //获取UIView约束中对应属性的约束对象
    func getTargetConstraint(_ targetAtt:NSLayoutConstraint.Attribute) -> NSLayoutConstraint! {
        var result:NSLayoutConstraint!;
        for con in self.constraints {
            if(con.firstItem as? UIView == self && con.firstAttribute == targetAtt) {
                result = con;
                break;
            }
        }
        return result;
    }
    
    func addConstraintsVisualFormat(_ format: String, views: [String : AnyObject]) {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views));
    }
    
    func addConstraintMultiple(_ multiplier: CGFloat, item view1: AnyObject, toItem view2: AnyObject?, attribute attr: NSLayoutConstraint.Attribute) {
        self.addConstraint(NSLayoutConstraint(item: view1, attribute: attr, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view2, attribute: attr, multiplier: multiplier, constant: 0));
    }
    
    func addConstraintWidthMultiple(_ multiplier: CGFloat, item view1: AnyObject, toItem view2: AnyObject?) {
        self.addConstraintMultiple(multiplier, item: view1, toItem: view2, attribute: NSLayoutConstraint.Attribute.width);
    }
    
    func addConstraintHeightMultiple(_ multiplier: CGFloat, item view1: AnyObject, toItem view2: AnyObject?) {
        self.addConstraintMultiple(multiplier, item: view1, toItem: view2, attribute: NSLayoutConstraint.Attribute.height);
    }
    
    //set Height or Width
    func addConstraintValue( item view1: AnyObject, attribute attr: NSLayoutConstraint.Attribute,constant cons:CGFloat) {
        self.addConstraint(NSLayoutConstraint(item: view1, attribute: attr, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute , multiplier: 1.0, constant: cons));
    }
    
    //Width : Height = Multiple
    func addConstraintWidthAndHeightMultiple(_ multiplier: CGFloat, item view1: AnyObject) {
        self.addConstraint(NSLayoutConstraint(item: view1, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view1, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0));
    }
    
    //fullscreen for self view
    func addSubViewForFullScreen(_ subView:UIView)  {
        self.addSubview(subView);
        self.addConstraintMultiple(1.0, item: self, toItem: subView, attribute: .top);
        self.addConstraintMultiple(1.0, item: self, toItem: subView, attribute: .bottom);
        self.addConstraintMultiple(1.0, item: self, toItem: subView, attribute: .leading);
        self.addConstraintMultiple(1.0, item: self, toItem: subView, attribute: .trailing);
    }
}
