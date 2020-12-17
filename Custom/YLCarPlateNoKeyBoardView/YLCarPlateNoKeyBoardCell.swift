//
//  YLCarPlateNoKeyBoardCell.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

typealias YLClicked = (_ indexPath: IndexPath) -> Void;

class YLCarPlateNoKeyBoardCell: UICollectionViewCell {
    private var _model: YLCarPlateNoKeyBoardCellModel!
    var model: YLCarPlateNoKeyBoardCellModel! {
        set {
            _model = newValue;
            self.imageView.image = newValue.image;
            self.btn.setTitle(newValue.text, for: .normal);
            self.btn.setTitleColor(YLRGB(51, 51, 51), for: .normal);
            self.flagView.label.text = newValue.text;
            self.resetColor();
        }
        get {
            return _model;
        }
    }
    
    var indexPath: IndexPath!;
    var clicked: YLClicked?;
    
    private var btn: UIButton!;
    private var imageView: UIImageView!;
    private var flagView: YLCarPlateNoKeyBoardFlagView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        btn = UIButton.init(type: .custom);
        btn.translatesAutoresizingMaskIntoConstraints = false;
        btn.addTarget(self, action: #selector(touchDown), for: .touchDown);
        btn.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside);
        btn.addTarget(self, action: #selector(touchUp), for: .touchUpOutside);
        btn.addTarget(self, action: #selector(touchUp), for: .touchCancel);
        btn.titleLabel?.adjustsFontSizeToFitWidth = true;
        btn.setTitleColor(YLRGB(51, 51, 51), for: .normal);
        btn.backgroundColor = .white;
        btn.layer.cornerRadius = 3;
        self.contentView.addSubview(btn);
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20));
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(imageView);
        
        flagView = YLCarPlateNoKeyBoardFlagView();
        flagView.isHidden = true;
        flagView.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(flagView);
        self.setupConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        self.btn.snp_makeConstraints { (make) in
            make.top.equalToSuperview().offset(8);
            make.left.equalToSuperview().offset(2);
            make.bottom.right.equalToSuperview().offset(-2);
        }
        
        self.imageView.snp_makeConstraints { (make) in
            make.center.equalToSuperview();
        }
        
        self.flagView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self.btn);
            make.bottom.equalTo(self.btn).offset(3);
            make.width.equalTo(self.btn).multipliedBy(60.0/32.0);
            make.height.equalToSuperview().multipliedBy(70.0/60.0)
        }
    }
    
    func resetColor() {
        if (model.isChangedKeyBoardBtnType) {
            self.btn.backgroundColor = YLRGB(21,126,251);
            self.btn.setTitleColor(YLRGB(255, 255, 255), for: .normal);
        } else if (model.isDeleteBtnType) {
            self.btn.backgroundColor = YLRGB(171, 178, 190);
        } else {
            self.btn.backgroundColor = UIColor(white: 1, alpha: 1);
        }
    }
    
    @objc func touchDown()  {
        if (self.model.text?.length == 0) {
            return ;
        }
        self.flagView.isHidden = false;
    }
    
    @objc func touchUp() {
        self.flagView.isHidden = true;
    }

    @objc func touchUpInside() {
        self.flagView.isHidden = true;
        if (self.clicked != nil) {
            self.clicked!(self.indexPath);
        }
    }
}
