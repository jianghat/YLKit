//
//  YLAgreementView.swift
//  Driver
//
//  Created by ym on 2020/9/28.
//

import UIKit
import YYKit

private let kAgreementAnswerKey = "YLAgreementAnswer"


class YLAgreementView: YLBasePopView {
    private var flag : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(flag: Int) {
        self.init(frame:CGRect.zero)
        self.flag = flag
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.contentView = UIView.init()
        self.contentView.backgroundColor = UIColor.white;
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.messageLabel)
        self.contentView.addSubview(self.cancelButton)
        self.contentView.addSubview(self.doneButton)
        
        if (self.flag == 0) {
            let text = NSMutableAttributedString.init(string: "感谢您的信任并使用趣买买！\n我们依据最新的法规及监管政策要求，更新了《趣买买用户协议》及《趣买买隐私政策》，特此向您推送此说明，以便继续为您服务。\n请仔细阅读《趣买买用户协议》（也可称为“服务条款”）并理解相关条款内容，在确认充分理解并同意后使用趣买买相关产品或服务。点击同意及代表您已阅读《趣买买用户协议》及《趣买买隐私政策》。如果您不同意，将可能影响使用趣买买相关产品或服务。", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black])
            //设置高亮色和点击事件
            var regex = try! NSRegularExpression.init(pattern: "《趣买买用户协议》", options: .caseInsensitive)
                
            var array = regex.matches(in: text.string, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, text.string.length))
                
            for result in array {
                text.setTextHighlight(result.range, color: UIColor.orange, backgroundColor: UIColor.clear) { (view, text, range, rect) in
                    self.dismiss()
                    
                }
            }
            
            //设置高亮色和点击事件
            regex =  try! NSRegularExpression.init(pattern: "《趣买买隐私政策》", options: .caseInsensitive)
            
            array = regex.matches(in: text.string, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, text.string.length))
            
            for result in array {
                text.setTextHighlight(result.range, color: UIColor.orange, backgroundColor: UIColor.clear) { (view, text, range, rect) in
                    self.dismiss()
                    
                }
            }
            self.messageLabel.attributedText = text;
        } else {
            let text = NSMutableAttributedString.init(string: "新的隐私政策能够更好地保护您的权益，同意后继续使用", attributes:  [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black])
            self.messageLabel.attributedText = text;
        }
        
        let layout = YYTextLayout(containerSize: CGSize(width: YLScreenWidth - 60, height: CGFloat.greatestFiniteMagnitude), text: self.messageLabel.attributedText!)
        self.layoutWith(layout!.textBoundingRect.size.height)
    }
    
    fileprivate func layoutWith(_ height: CGFloat) {
        self.contentView.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(15);
            make.right.equalToSuperview().offset(-15);
            make.centerY.equalToSuperview()
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(15);
            make.centerX.equalToSuperview();
        }
        
        self.messageLabel.snp_makeConstraints { (make) in
            make.left.equalToSuperview().offset(15);
            make.right.equalToSuperview().offset(-15);
            make.top.equalTo(self.titleLabel.snp_bottom).offset(15);
            make.height.equalTo(height);
        }
    
        self.cancelButton.snp_makeConstraints { (make) in
            make.right.equalToSuperview().dividedBy(2)
            make.left.bottom.equalToSuperview();
            make.height.equalTo(44);
        }

        self.doneButton.snp_makeConstraints { (make) in
            make.right.bottom.equalToSuperview();
            make.left.equalTo(self.cancelButton.snp_right).offset(1);
            make.height.equalTo(44);
        }
        
        self.contentView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.messageLabel.snp_bottom).offset(86);
        }
    }
    
    
    // MARK Lazy Load
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.label(font: UIFont.boldSystemFont(ofSize: 16), textColor: UIColor.black)
        titleLabel.text = "温馨提示"
        return titleLabel
    }()
    
    lazy var messageLabel: UILabel = {
        let messageLabel = UILabel.label(fontSize: 16, textColor: UIColor.black)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        return messageLabel
    }()
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton.init()
        cancelButton.yl_borderLineAt(direction: .top, color: UIColor.gray, width: 1)
        cancelButton.yl_borderLineAt(direction: .right, color: UIColor.gray, width: 1)
        cancelButton.setColorOfNormal(UIColor.gray)
        cancelButton.setTitleOfNormal("不同意")
        cancelButton.setFontOfSize(size: 15)
        cancelButton.setActionTouchUpInside { [weak self] (sender) in
            if self?.flag == 1 {
                exit(0)
            } else {
                self?.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: {
                    let agreementView = YLAgreementView.init(flag: 1)
                    agreementView.isMaskDismiss = false
                    agreementView.show()
                })
            }
        }
        return cancelButton
    }()
    
    lazy var doneButton: UIButton = {
        let doneButton = UIButton.init()
        doneButton.yl_borderLineAt(direction: .top, color: UIColor.gray, width: 1)
        doneButton.setColorOfNormal(YLRGB(47,123,225))
        doneButton.setTitleOfNormal("同意")
        doneButton.setFontOfSize(size: 15)
        doneButton.setActionTouchUpInside { [weak self] (sender) in
            let defaults = Foundation.UserDefaults.standard;
            defaults.setValue(true, forKey: kAgreementAnswerKey)
            defaults.synchronize()
            self?.dismiss()
        }
        return doneButton
    }()
}
