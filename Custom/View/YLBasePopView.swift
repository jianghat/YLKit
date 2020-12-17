//
//  YLBasePopView.swift
//  Driver
//
//  Created by ym on 2020/9/28.
//

import UIKit

enum AlertAnimation {
    case None
    case Top
    case Bottom
    case Left
    case Right
    case Center
}

class YLBasePopView: UIView {
    public var contentView: UIView = UIView() {
        didSet {
            self.contentView.setCornerRadius(self.cornerRadius)
            self.addSubview(contentView)
        }
    }
    
    /** contentView圆角值*/
    public var cornerRadius: CGFloat = 8 {
        didSet {
            self.contentView.setCornerRadius(cornerRadius)
        }
    }
    
    public var isMaskDismiss: Bool = true
    private var animation: AlertAnimation = .None
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        self.show(animation: .None)
    }
    
    public func show(animation: AlertAnimation) {
        self.animation = animation
        self.endEditing(true)
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        self.contentView.alpha = 0;
        self.layoutIfNeeded()
        
        dispatch_async_on_main_queue {
            let frame = self.contentView.frame
            switch self.animation {
            case .None:
                self.contentView.alpha = 1
            case .Top:
                self.contentView.top = self.frame.size.height - frame.size.height
                self.contentView.alpha = 1
                UIView.animate(withDuration: 0.25) {
                    self.contentView.frame = frame
                }
            case .Bottom:
                self.contentView.top = self.frame.height + frame.size.height
                self.contentView.alpha = 1
                UIView.animate(withDuration: 0.25) {
                    self.contentView.top = self.frame.height - frame.size.height
                }
            case .Left:
                self.contentView.frame = CGRect(x: self.frame.size.width - frame.size.width, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
                self.contentView.alpha = 1
                UIView.animate(withDuration: 0.25) {
                    self.contentView.frame = frame
                }
            case .Right:
                self.contentView.frame = CGRect(x: self.frame.size.width + frame.size.width, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
                self.contentView.alpha = 1
                UIView.animate(withDuration: 0.25) {
                    self.contentView.frame = frame
                }
            case .Center:
                UIView.animate(withDuration: 0.25) {
                    self.contentView.alpha = 1
                }
            }
        }
    }
    
    public func dismiss() {
        self.dismiss(animation: self.animation)
    }
    
    public func dismiss(animation: AlertAnimation) {
        switch animation {
        case .Center:
            UIView.animate(withDuration: 0.25) {
                self.contentView.alpha = 0
            } completion: { (finished) in
                self.removeFromSuperview()
            }
        case .None:
            self.removeFromSuperview()
        case .Top:
            UIView.animate(withDuration: 0.25) {
                self.contentView.top = self.height - self.contentView.height
            } completion:{ (finished) in
                self.removeFromSuperview()
            }
        case .Bottom:
            UIView.animate(withDuration: 0.25) {
                self.contentView.top = self.height + self.contentView.height
            } completion:{ (finished) in
                self.removeFromSuperview()
            }
        case .Left:
            UIView.animate(withDuration: 0.25) {
                self.contentView.frame = CGRect(x: self.frame.size.width - self.contentView.frame.size.width, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
            } completion: { (finished) in
                self.removeFromSuperview()
            }
        case .Right:
            UIView.animate(withDuration: 0.25) {
                self.contentView.frame = CGRect(x: self.frame.size.width + self.contentView.frame.size.width, y: self.contentView.frame.origin.y, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
            } completion:{ (finished) in
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func didReceiveTouchEvent(event: UIEvent) -> Void {
        if self.isMaskDismiss == true {
            self.dismiss()
        }
    }
    
    fileprivate func setupUI() {
        self.isMaskDismiss = true;
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addSubview(self.controlView)
        self.controlView.snp_makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }
    
    private lazy var controlView: UIControl = {
        let controlView = UIControl.init(frame: UIScreen.main.bounds)
        controlView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controlView.backgroundColor = UIColor.clear
        controlView.addTarget(self, action: #selector(didReceiveTouchEvent(event:)), for: .touchDown)
        return controlView
    }()
}

