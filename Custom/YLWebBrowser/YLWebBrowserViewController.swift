//
//  YLWebBrowserViewController.swift
//  Driver
//
//  Created by ym on 2020/9/30.
//

import UIKit
import WebKit

class YLWebBrowserViewController: YLBaseViewController {
    var url: String!
    
    class func showInViewContoller(_ viewController: UIViewController, url: String) {
        let browser: YLWebBrowserViewController = YLWebBrowserViewController.init();
        browser.url = url;
        viewController.navigationController?.pushViewController(browser, animated: true);
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.view.addSubview(self.webView)
        self.view.addSubview(self.progressView)
        self.view.bringSubviewToFront(self.progressView)
        self.progressView.snp_makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(3)
        }
        
        self.webView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.startLoad()
    }
    
    fileprivate func startLoad() {
        let request = URLRequest(url: URL(string: self.url)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 1000)
        self.webView.load(request)
    }
    
    public func loadWebPageWithURL(title: String, url: String) {
        self.title = title
        self.url = url
    }
    
    // 进度条
    lazy var progressView:UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = UIColor.orange
        progress.trackTintColor = .clear
        return progress
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.uiDelegate = self;
        webView.navigationDelegate = self;
        return webView
    }()
}

extension YLWebBrowserViewController: WKUIDelegate,WKNavigationDelegate {
    //MARK:WKNavigationDelegate
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        /// 获取网页title
        self.title = self.webView.title
        
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
    
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            self.progressView.alpha = 1.0
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
}

