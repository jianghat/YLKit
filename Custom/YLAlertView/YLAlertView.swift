//
//  YLAlertView.swift
//  Driver
//
//  Created by ym on 2020/9/28.
//

import Foundation
import YYKit

typealias YLButtonTappedIndexBlock = (_ index: Int) -> Void

class YLAlertView: YLBasePopView {
    private let maxWidth = UIScreen.main.bounds.size.width - 40
    public var buttonTappedIndexBlock: YLButtonTappedIndexBlock?
    private var title: String?
    private var message: String?
    private var cancelTitle: String?
    private var okTitle: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String?, message: String?, cancelTitle: String?, okTitle: String?) {
        self.init(frame: CGRect.zero)
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.okTitle = okTitle
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView = UIView.init()
        self.contentView.backgroundColor = UIColor.white;
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.cancelButton)
        self.contentView.addSubview(self.doneButton)
        let size = self.messageLabel.text?.sizeWithFont(self.messageLabel.font, constrainedToWidth: maxWidth)
        self.layout(size!)
    }
    
    fileprivate func layout(_ contentSize: CGSize) {
        self.contentView.snp_makeConstraints{ (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.center.equalToSuperview()
        }
        
        self.titleLabel.snp_makeConstraints{ (make) in
            make.top.equalToSuperview().offset(15);
            make.centerX.equalToSuperview();
        }
        
        self.messageLabel.snp_makeConstraints{ (make) in
//            make.left.equalToSuperview().offset(15).priorityLow()
//            make.right.equalToSuperview().offset(-15).priorityLow()
            make.top.equalTo(self.titleLabel.snp_bottom).offset(15)
            make.height.equalTo(contentSize.height)
            make.centerX.equalToSuperview()
        }
        
        self.cancelButton.snp_makeConstraints{ (make) in
            make.right.equalTo(self.cancelButton.superview!.snp_centerX)
            make.left.bottom.equalToSuperview()
            make.height.equalTo(44);
        }
        
        self.doneButton.snp_makeConstraints{ (make) in
            make.left.equalTo(self.cancelButton.snp_right)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(44);
        }
        
        self.contentView.snp_makeConstraints{ (make) in
            make.bottom.equalTo(self.messageLabel.snp_bottom).offset(86);
        }
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.label(font: UIFont.boldSystemFont(ofSize: 16), textColor: UIColor.black)
        titleLabel.text = self.title
        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel.label(fontSize: 16, textColor: UIColor.black)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.text = self.message
        return messageLabel
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton.init()
        cancelButton.yl_borderLineAt(direction: .top, color: UIColor.groupTableViewBackground, width: 1)
        cancelButton.yl_borderLineAt(direction: .right, color: UIColor.groupTableViewBackground, width: 1)
        cancelButton.setColorOfNormal(UIColor.colorWithHexString("ACACAD"))
        cancelButton.setFontOfSize(size: 18)
        cancelButton.setActionTouchUpInside { [weak self] (sender) in
            self?.dismiss()
            self?.buttonTappedIndexBlock?(0)
        }
        cancelButton.setTitleOfNormal(self.cancelTitle ?? "取消")
        return cancelButton
    }()
    
    lazy var doneButton: UIButton = {
        let doneButton = UIButton.init()
        doneButton.yl_borderLineAt(direction: .top, color: UIColor.groupTableViewBackground, width: 1)
        doneButton.setColorOfNormal(UIColor.colorWithHexString("3CA0F4"))
        doneButton.setFontOfSize(size: 18)
        doneButton.setActionTouchUpInside { [weak self] (sender) in
            self?.dismiss()
            self?.buttonTappedIndexBlock?(1)
        }
        doneButton.setTitleOfNormal(self.okTitle ?? "确认")
        return doneButton
    }()
}
