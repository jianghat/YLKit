//
//  YLCarPlateNoKeyBoardCellModel.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

class YLCarPlateNoKeyBoardCellModel: NSObject {
    var text: String?;
    var image: UIImage?;
    
    var isChangedKeyBoardBtnType: Bool = false;
    var isDeleteBtnType: Bool = false;
    
    override init() {
        super.init();
    }
}

