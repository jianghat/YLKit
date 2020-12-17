//
//  YLTableView.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import UIKit

class YLTableView: UITableView {
    /**
     *  是否隐藏多余分割线,默认是YES
     */
    var surplusSeparatorEnabled: Bool = false {
        didSet {
            self.tableFooterView = UIView.init()
        }
    }
    
    /**
     *  分割线是否从0开始,默认为NO
     *  在ios8系统下要是用户自己实现dataSource代理方法的话,这个属性会不起作用的
     */
    var separatorZeroEnabled: Bool = false {
        didSet {
            if (separatorZeroEnabled) {
                if Float(YLCurrentDevice.systemVersion)! >= 7.0 {
                    if self.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                        self.separatorInset = .zero
                    }
                }
                
                if Float(YLCurrentDevice.systemVersion)! >= 8.0 {
                    if self.responds(to:#selector(setter: UIView.layoutMargins)) {
                        self.layoutMargins = .zero
                    }
                }
            }
        }
    }
    
    /**
     *  总数
     */
    var totalPage: Int = 1
    
    /**
     *  页码
     */
    var pageNumber: Int = 1
    
    /**
     *  每页数量
     */
    var pageSize: Int = 20
    
    /**
     *  数组集合
     */
    var tableArray: Array<Any> = []
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setDefaultParameters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDefaultParameters() {
        self.backgroundColor = UIColor.clear
        self.estimatedRowHeight = 0
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.separatorZeroEnabled = false
    }
    
    /**
     *  去掉section黏性,一般写在scrollViewDidScroll代理方法里面的
     */
    func removeSectionStickiness() {
        let sectionHeaderHeight: CGFloat = 44 //section的高度
        if (self.contentOffset.y <= sectionHeaderHeight && self.contentOffset.y >= 0) {
            self.contentInset = UIEdgeInsets(top: -self.contentOffset.y, left: 0, bottom: 0, right: 0)
        } else if (self.contentOffset.y >= sectionHeaderHeight) {
            self.contentInset = UIEdgeInsets(top: -sectionHeaderHeight, left: 0, bottom: 0, right: 0);
        }
    }
    
    /**
     *  第一次添加数据
     *
     *  @param array 数据源
     */
    func addFirstArray(array: Array<Any>) {
        self.tableArray.removeAll()
        self.tableArray.append(array)
        self.reloadData()
    }
    
    /**
     *  加载更多数据
     *
     *  @param array 数据源
     */
    func addMoreArray(array: Array<Any>) {
        if array.count == 0 {
            return
        }
        
        let indexPaths:Array = [IndexPath.init(row: self.tableArray.count - 1, section: 0)]
        let index = self.tableArray.count;
        var indexPathArray: Array<IndexPath> = []
        self.tableArray.append(contentsOf: array)
        for _ in (index ..< self.tableArray.count) {
            indexPathArray.append(IndexPath.init(row: index, section: 0))
        }
        self.beginUpdates()
        self.insertRows(at: indexPathArray, with: .fade)
        self.endUpdates()
        self.reloadRows(at: indexPaths, with: .none)
    }
    
    /**
     *  返回数据
     *
     *  @param indexPath indexPath
     *
     *  @return 数据源
     */
    func itemAtIndexPath(indexPath: NSIndexPath) -> Any? {
        if indexPath.row > self.tableArray.count {
            return nil
        }
        return self.tableArray[indexPath.row]
    }
}
