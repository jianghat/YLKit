//
//  UINavigationController+YLFDFullscreenPopGesture.swift
//  Driver
//
//  Created by ym on 2020/10/9.
//

import UIKit

typealias _FDViewControllerWillAppearInjectBlock = (_ viewController: UIViewController, _ animated: Bool) -> Void

open class YLFDFullscreenPopGesture: NSObject {
    open class func loadSwizzledMethod() {
        UINavigationController.yl_nav_initialize()
        UIViewController.yl_vc_initialize()
    }
}

fileprivate class _FDViewControllerWillAppearInjectBlockContainer {
    var block: _FDViewControllerWillAppearInjectBlock?
    init(_ block: @escaping _FDViewControllerWillAppearInjectBlock) {
        self.block = block
    }
}

class _FDFullscreenPopGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    var navigationController: UINavigationController?
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let nav = self.navigationController else {
            return false
        }
        
        if nav.viewControllers.count <= 1 {
            return false
        }
        
        let topViewController = nav.viewControllers.last! as UIViewController;
        if (topViewController.yl_interactivePopDisabled) {
            return false
        }
        
        if nav.value(forKey: "_isTransitioning") as! Bool {
            return false
        }
        
        let translation = gestureRecognizer.location(in: gestureRecognizer.view)
        if (translation.x <= 0) {
            return false
        }
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
            let recognizer = gestureRecognizer as! UIPanGestureRecognizer;
            let point: CGPoint = recognizer.translation(in: recognizer.view);
            if point.x <= 0 {
                return false
            }
        }
        return true;
    }
}


fileprivate struct YLFullPopRuntimeKey {
    static let KEY_willAppearInjectBlockContainer
        = UnsafeRawPointer(bitPattern: "KEY_YL_willAppearInjectBlockContainer".hashValue)!
    static let KEY_interactivePopDisabled
        = UnsafeRawPointer(bitPattern: "KEY_YL_interactivePopDisabled".hashValue)!
    static let KEY_prefersNavigationBarHidden
        = UnsafeRawPointer(bitPattern: "KEY_YL_prefersNavigationBarHidden".hashValue)!
    static let KEY_interactivePopMaxAllowedInitialDistanceToLeftEdge
        = UnsafeRawPointer(bitPattern: "KEY_YL_interactivePopMaxAllowedInitialDistanceToLeftEdge".hashValue)!
    static let KEY_fullscreenPopGestureRecognizer
        = UnsafeRawPointer(bitPattern: "KEY_YL_fullscreenPopGestureRecognizer".hashValue)!
    static let KEY_popGestureRecognizerDelegate
        = UnsafeRawPointer(bitPattern: "KEY_YL_popGestureRecognizerDelegate".hashValue)!
    static let KEY_viewControllerBasedNavigationBarAppearanceEnabled
        = UnsafeRawPointer(bitPattern: "KEY_sh_viewControllerBasedNavigationBarAppearanceEnabled".hashValue)!
    static let KEY_scrollViewPopGestureRecognizerEnable
        = UnsafeRawPointer(bitPattern: "KEY_YL_scrollViewPopGestureRecognizerEnable".hashValue)!
}

extension UINavigationController {
    fileprivate class func yl_nav_initialize() {
        DispatchQueue.once(token: "com.UINavigationController.MethodSwizzling", block: {
            let originalSelector = #selector(pushViewController(_:animated:))
            let swizzledSelector = #selector(yl_pushViewController(_:animated:))
            self.swizzleInstanceMethod(originalSel: originalSelector, newSel: swizzledSelector)
        })
    }
    
    @objc private func yl_pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.interactivePopGestureRecognizer?.view?.gestureRecognizers?.contains(self.yl_fullscreenPopGestureRecognizer)) == false {
            self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(self.yl_fullscreenPopGestureRecognizer)
            
            // Forward the gesture events to the private handler of the onboard gesture recognizer.
            let internalTargets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as? Array<NSObject>
            let internalTarget = internalTargets?.first?.value(forKey: "target")
            let internalAction = NSSelectorFromString("handleNavigationTransition:");
            if let target = internalTarget {
                self.yl_fullscreenPopGestureRecognizer.delegate = self.yl_popGestureRecognizerDelegate
                self.yl_fullscreenPopGestureRecognizer.addTarget(target, action: internalAction)
            }
            
            // Disable the onboard gesture recognizer.
            self.interactivePopGestureRecognizer?.isEnabled = false;
        }
        
        // Handle perferred navigation bar appearance.
        self.yl_setupViewControllerBasedNavigationBarAppearanceIfNeeded(viewController)
        
        // Forward to primary implementation.
        self.yl_pushViewController(viewController, animated: animated)
    }
    
    private func yl_setupViewControllerBasedNavigationBarAppearanceIfNeeded(_ appearingViewController: UIViewController) {
        if !self.yl_viewControllerBasedNavigationBarAppearanceEnabled {
            return
        }
        
        let blockContainer = _FDViewControllerWillAppearInjectBlockContainer() { [weak self] (_ vc: UIViewController, _ animated: Bool) -> Void in
            self?.setNavigationBarHidden(vc.yl_prefersNavigationBarHidden, animated: animated)
        }
        
        // Setup will appear inject block to appearing view controller.
        // Setup disappearing view controller as well, because not every view controller is added into
        // stack by pushing, maybe by "-setViewControllers:".
        appearingViewController.yl_willAppearInjectBlock = blockContainer
        let disappearingViewController = self.viewControllers.last
        if let vc = disappearingViewController {
            if vc.yl_willAppearInjectBlock == nil {
                vc.yl_willAppearInjectBlock = blockContainer
            }
        }
    }
    
    /// The gesture recognizer that actually handles interactive pop.
    private var yl_fullscreenPopGestureRecognizer: UIPanGestureRecognizer {
        get {
            guard let rs = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_fullscreenPopGestureRecognizer) as? UIPanGestureRecognizer else {
                let gesture = UIPanGestureRecognizer.init()
                gesture.maximumNumberOfTouches = 1
                objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_fullscreenPopGestureRecognizer, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return gesture
            }
            return rs
        }
    }
    
    /// A view controller is able to control navigation bar's appearance by itself,
    /// rather than a global way, checking "yl_prefersNavigationBarHidden" property.
    /// Default to YES, disable it if you don't want so.
    private var yl_viewControllerBasedNavigationBarAppearanceEnabled: Bool {
        get {
            guard let bools = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_viewControllerBasedNavigationBarAppearanceEnabled) as? Bool else {
                self.yl_viewControllerBasedNavigationBarAppearanceEnabled = true
                return true
            }
            return bools
        }
        set {
            objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_viewControllerBasedNavigationBarAppearanceEnabled, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    fileprivate var yl_popGestureRecognizerDelegate: _FDFullscreenPopGestureRecognizerDelegate {
        get {
            guard let delegate = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_popGestureRecognizerDelegate) as? _FDFullscreenPopGestureRecognizerDelegate else {
                let delegate_ = _FDFullscreenPopGestureRecognizerDelegate()
                delegate_.navigationController = self
                objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_popGestureRecognizerDelegate, delegate_, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return delegate_
            }
            return delegate
        }
    }
}

extension UIViewController {
    fileprivate class func yl_vc_initialize() {
        DispatchQueue.once(token: "com.UIViewController.MethodSwizzling", block: {
            let originalSelector = #selector(self.viewWillAppear(_:))
            let swizzledSelector = #selector(self.yl_viewWillAppear(_:))
            self.swizzleInstanceMethod(originalSel: originalSelector, newSel: swizzledSelector)
        })
    }
    
    @objc private func yl_viewWillAppear(_ animated: Bool) {
        self.yl_viewWillAppear(animated)
        if let block = self.yl_willAppearInjectBlock?.block {
            block(self, animated)
        }
    }
    
    /// Whether the interactive pop gesture is disabled when contained in a navigation
    /// stack.
    public var yl_interactivePopDisabled: Bool {
        get {
            guard let rs = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_interactivePopDisabled) as? Bool else {
                return false
            }
            return rs
        }
        set {
            objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_interactivePopDisabled, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// Indicate this view controller prefers its navigation bar hidden or not,
    /// checked when view controller based navigation bar's appearance is enabled.
    /// Default to NO, bars are more likely to show.
    public var yl_prefersNavigationBarHidden: Bool {
        get {
            guard let rs = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_prefersNavigationBarHidden) as? Bool else {
                return false
            }
            return rs
        }
        set {
            objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_prefersNavigationBarHidden, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    fileprivate var  yl_willAppearInjectBlock: _FDViewControllerWillAppearInjectBlockContainer? {
        get {
            let block = objc_getAssociatedObject(self, YLFullPopRuntimeKey.KEY_willAppearInjectBlockContainer) as? _FDViewControllerWillAppearInjectBlockContainer
            return block
        }
        set {
            objc_setAssociatedObject(self, YLFullPopRuntimeKey.KEY_willAppearInjectBlockContainer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
