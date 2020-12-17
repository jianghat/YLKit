//
//  YLCarPlateNoKeyBoardFlagView.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

class YLCarPlateNoKeyBoardFlagView: UIView {
    var imageView: UIImageView!;
    var label: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView();
        imageView.contentMode = .scaleAspectFill;
        imageView.image = YLImageNamed("YLCarPlateNoKeyBoardView/rzKeyBoardFlag");
        self.addSubview(imageView);
        
        label = UILabel();
        label.font = UIFont.systemFont(ofSize: 30);
        label.textAlignment = .center;
        self.addSubview(label);
        
        self.setconstraint(view: label);
        self.setconstraint(view: imageView);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setconstraint(view: UIView!) {
        view!.translatesAutoresizingMaskIntoConstraints = false;
        
        let top = NSLayoutConstraint.init(item: view!, attribute: .top, relatedBy: NSLayoutConstraint.Relation.init(rawValue: 0)!, toItem: self, attribute: .top, multiplier: 1, constant: 0);
        
        let left = NSLayoutConstraint.init(item: view!, attribute: .left, relatedBy: NSLayoutConstraint.Relation.init(rawValue: 0)!, toItem: self, attribute: .left, multiplier: 1, constant: 0)
            
        let bottom = NSLayoutConstraint.init(item: view!, attribute: .bottom, relatedBy: NSLayoutConstraint.Relation.init(rawValue: 0)!, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let right = NSLayoutConstraint.init(item: view!, attribute: .right, relatedBy: NSLayoutConstraint.Relation.init(rawValue: 0)!, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        
        self.addConstraints([top, left, bottom, right]);
    }
}
