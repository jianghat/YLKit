//
//  YLBaseTableViewController.swift
//  Driver
//
//  Created by ym on 2020/9/25.
//  Copyright © 2020 edonesoft. All rights reserved.
//

import UIKit
import SnapKit

class YLBaseTableViewController: YLBaseViewController {
    var _style = UITableView.Style.plain
    var pageSize: Int = 10;
    
    convenience init(style: UITableView.Style) {
        self.init()
        _style = style
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView);
        self.tableView.snp_makeConstraints { (make) in
            make.left.top.right.equalToSuperview();
            make.bottom.equalToSuperview().offset(-YLFullTabbarExtraHeight);
        }
    }
    
    // MARk: lazy getter
    lazy var tableView: UITableView = {
        var tableView = UITableView.init(frame: CGRect.zero, style: _style);
        tableView.tableFooterView = UIView();
        tableView.dataSource = self;
        tableView.delegate = self;
        return tableView;
    }();
    
    lazy var dataSource: [Any] = {
        let dataSource: [Any] = [];
        return dataSource;
    }();
}

extension YLBaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK:  - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
