//
//  YLCarPlateNoKeyBoardView.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

typealias YLKeyboardEditingBlock = (_ isDel: Bool?, _ text: String?) -> Void;

class YLCarPlateNoKeyBoardView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let viewModel: YLCarPlateNoKeyBoardViewModel! = YLCarPlateNoKeyBoardViewModel();
    private let cellHeight: CGFloat = 54;
    private var cellWidth: CGFloat {
        get {
            if self.isProvince {
                return min(60, YLScreenWidth/8.0);
            } else {
                return min(60, YLScreenWidth/10.0);
            }
        }
    };
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init();
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        let collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout);
        collectionView.register(YLCarPlateNoKeyBoardCell.self, forCellWithReuseIdentifier: "Cell");
        collectionView.backgroundColor = UIColor.groupTableViewBackground;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        return collectionView;
    }();
    
    private var _isProvince: Bool = true;
    public var isProvince: Bool {
        set {
            _isProvince = newValue;
            self.viewModel.isProvince = newValue;
        }
        get {
            return _isProvince;
        }
    }
    
    public var keyboardEditing :YLKeyboardEditingBlock?;
    
    override init(frame: CGRect) {
        let rect = CGRect(x: 0, y: 0, width: YLScreenWidth, height: self.cellHeight * 4 + YLFullTabbarExtraHeight + 10);
        super.init(frame: rect);
        self.addSubview(self.collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellClickedIndexPath(_ indexPath: IndexPath!) {
        let model: YLCarPlateNoKeyBoardCellModel = self.viewModel.dataSource[indexPath.section][indexPath.row];
        
        if (self.keyboardEditing != nil) {
            self.keyboardEditing!(model.isDeleteBtnType, model.text);
        }
    }
}

extension YLCarPlateNoKeyBoardView {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataSource[section].count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YLCarPlateNoKeyBoardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! YLCarPlateNoKeyBoardCell;
        cell.model = self.viewModel.dataSource[indexPath.section][indexPath.row];
        cell.indexPath = indexPath;
        cell.clicked = { [weak self] (indexPath) in
            self?.cellClickedIndexPath(indexPath);
        };
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let items: Array = self.viewModel.dataSource[section];
        let width: CGFloat = self.cellWidth * CGFloat(items.count);
        
        var leftMargin: CGFloat  = 0;
        if (width < collectionView.bounds.size.width) {
            leftMargin = (collectionView.bounds.size.width - width)/2.0; // 保证所有按钮居中
        }
        return UIEdgeInsets(top: 0, left: leftMargin, bottom: 0, right: leftMargin);
    }
}

