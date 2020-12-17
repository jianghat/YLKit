//
//  UIScrollView+YLRefresh.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import UIKit
import MJRefresh

extension UIScrollView {
    public func addNomalHeaderWithRefreshingBlock(block: @escaping () -> Void ) {
        let header = MJRefreshNormalHeader.init {
            block()
        }
        self.mj_header = header
    }
    
    public func addAutoNormalFooterWithRefreshingBlock(block: @escaping () -> Void ) {
        let footer = MJRefreshAutoNormalFooter.init {
            block()
        }
        self.mj_footer = footer
    }
    
    public func beginRefreshing () {
        self.mj_header?.beginRefreshing()
    }
    
    public func endRefreshing () {
        if self.mj_header?.isRefreshing ?? false {
            self.mj_header?.endRefreshing()
        }
        
        if self.mj_footer?.isRefreshing ?? false {
            self.mj_footer?.endRefreshing()
        }
    }
    
//    public func endRefreshingWithNoData () {
//        if self.isKind(of: UITableView.self) {
//            let tableView: UITableView = self as! UITableView;
//            tableView.tableFooterView =
//        }
//    }
    
    public func endRefreshingWithNoMoreData () {
        self.mj_footer?.endRefreshingWithNoMoreData();
    }
}

extension UIScrollView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}
