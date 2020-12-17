//
//  UIViewController+Refresh.swift
//  Driver
//
//  Created by ym on 2020/10/29.
//

import UIKit

extension UIViewController {
    private struct YLRefreshAssociateKeys {
        static var scrollViewKey: Void?;
        static var pageNumberKey: Void?;
        static var pullDownRefreshKey: Void?;
        static var pullUpRefreshKey: Void?;
    }
    
    private weak var yl_scrollView: UIScrollView? {
        get {
            return objc_getAssociatedObject(self, &YLRefreshAssociateKeys.scrollViewKey) as? UIScrollView;
        }
        set {
            objc_setAssociatedObject(self, &YLRefreshAssociateKeys.scrollViewKey, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    };
    
    private var isPullDownRefresh: Bool {
        get {
            return objc_getAssociatedObject(self, &YLRefreshAssociateKeys.pullDownRefreshKey) as? Bool ?? false;
        }
        set {
            if newValue {
                self.yl_scrollView?.addNomalHeaderWithRefreshingBlock { [weak self] in
                    self?.pageNumber = 1;
                    self?.loadDataWithLoadMore(false);
                }
            }
            objc_setAssociatedObject(self, &YLRefreshAssociateKeys.pullDownRefreshKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
        }
    }
    
    private var isPullUpRefresh: Bool {
        get {
            return objc_getAssociatedObject(self, &YLRefreshAssociateKeys.pullUpRefreshKey) as? Bool ?? false;
        }
        set {
            if newValue {
                self.yl_scrollView?.addAutoNormalFooterWithRefreshingBlock { [weak self] in
                    self?.pageNumber += 1
                    self?.loadDataWithLoadMore(true);
                }
            }
            objc_setAssociatedObject(self, &YLRefreshAssociateKeys.pullUpRefreshKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
        }
    }
    
    var pageNumber: Int {
        get {
            return objc_getAssociatedObject(self, &YLRefreshAssociateKeys.pageNumberKey) as? Int ?? 1;
        }
        set {
            objc_setAssociatedObject(self, &YLRefreshAssociateKeys.pageNumberKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
        }
    }
    
    func configRefreshUI(_ scrollView: UIScrollView, isRefresh: Bool, isDownLoad: Bool) {
        self.yl_scrollView = scrollView;
        self.isPullUpRefresh = isDownLoad;
        self.isPullDownRefresh = isRefresh;
    }
    
    @objc open func loadDataWithLoadMore(_ refresh: Bool) {
        
    }
    
    func yl_endRefreshing() {
        if yl_scrollView!.isKind(of: UITableView.self) {
            let tableView: UITableView = yl_scrollView as! UITableView;
            tableView.reloadData();
        } else if yl_scrollView!.isKind(of: UICollectionView.self) {
            let collectionView: UICollectionView = yl_scrollView as! UICollectionView;
            collectionView.reloadData();
        }
        self.yl_scrollView?.endRefreshing();
    }
}
