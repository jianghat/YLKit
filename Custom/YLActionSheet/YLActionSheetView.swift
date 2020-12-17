//
//  YLActionSheetView.swift
//  Driver
//
//  Created by ym on 2020/9/28.
//

import UIKit

protocol YLActionSheetViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

class YLActionSheetViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.frame = self.bounds
    }
    
    // Mark Load
    public private (set) lazy var titleLabel: UILabel = {
        let label = UILabel.label(fontSize: 14, textColor: UIColor.black)
        label.textAlignment = .center
        return label
    }()
}

class YLActionSheetView: YLBasePopView {
    var title: String?
    var cancelTitle: String?
    var splitHeight: CGFloat = 10.0
    var dataSource: YLActionSheetViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMaskDismiss = false
    }
    
    convenience init(title: String, cancelTitle: String?) {
        self.init(frame: .zero)
        self.title = title
        self.cancelTitle = cancelTitle
        self.setupUI()
    }
    
    open func addAction(_ action: YLAction) {
        self.tableView.tableArray.append(action)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        self.headerView.snp_updateConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(44)
        }
        
        self.tableView.snp_updateConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.headerView.snp_bottom)
        }
        super.updateConstraints()
    }
    
    override func show() {
        var height: CGFloat = 44 + splitHeight
        height += CGFloat(self.tableView.tableArray.count * 44)
        self.contentView.height = height
        super.show(animation: .Bottom)
    }
    
    fileprivate func setupUI() {
        self.contentView = UIView.init(frame: CGRect(x: 0, y: 0, width: YLScreenWidth, height: 0))
        self.headerView.titleLabel?.text = self.title
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.tableView)
    }
    
    // Mark Lazy load
    fileprivate lazy var headerView: YLActionSheetHeaderView = {
        let headerView = YLActionSheetHeaderView(frame: CGRect(x: 0, y: 0, width: YLScreenWidth, height: 44))
        headerView.cancelButton?.setActionTouchUpInside({ [weak self] (sender) in
            self?.dismiss()
        })
        
        headerView.doneButton?.setActionTouchUpInside({ [weak self] (sender) in
            self?.dismiss()
        })
        return headerView
    }()
    
    fileprivate lazy var tableView: YLTableView = {
        let tableView = YLTableView.init(frame: .zero, style: .plain)
        tableView.register(YLActionSheetViewCell.self, forCellReuseIdentifier: YLActionSheetViewCell.className())
        tableView.separatorZeroEnabled = true
        tableView.isScrollEnabled = false
        tableView.delegate = self;
        tableView.dataSource = self;
        return tableView
    }()
}

extension YLActionSheetView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YLActionSheetViewCell = tableView.dequeueReusableCell(withIdentifier: YLActionSheetViewCell.className(), for: indexPath) as! YLActionSheetViewCell
        cell.selectionStyle = .none
        
        let action: YLAction = self.tableView.tableArray[indexPath.row] as! YLAction
        cell.titleLabel.text = action.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action: YLAction = self.tableView.tableArray[indexPath.row] as! YLAction
        if action.handler != nil {
            action.handler!(action)
            self.dismiss()
        }
    }
}
