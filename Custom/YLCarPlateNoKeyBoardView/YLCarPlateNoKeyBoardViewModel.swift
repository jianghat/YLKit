//
//  YLCarPlateNoKeyBoardViewModel.swift
//  Driver
//
//  Created by ym on 2020/11/2.
//

import UIKit

let province: String = "京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领";
let province_Regex: String = "[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]";
let province_code_Regex: String = "[A-Z]";
let plateNo_code_Regex: String = "[A-Z0-9]";
let plateNo_code_end_Regx: String = "[A-Z0-9挂学警港澳]";

class YLCarPlateNoKeyBoardViewModel: NSObject {
    var dataSource: [[YLCarPlateNoKeyBoardCellModel]]!;
    var isProvince: Bool = true {
        willSet {
            if (newValue) {
                self.dataSource = self.provinces;
            } else {
                self.dataSource = self.noAndChars;
            }
        }
    };
    
    lazy var provinces: [[YLCarPlateNoKeyBoardCellModel]] = {
        let provinces = [["京","津","冀","晋","蒙","辽","吉","黑"],
                         ["沪","苏","浙","皖","闽","赣","鲁","豫"],
                         ["鄂","湘","粤","桂","琼","渝","川","贵"],
                         ["云","藏","陕","甘","青","宁","新"]];
        var array = [[YLCarPlateNoKeyBoardCellModel]]();
        for (idx, objArray) in provinces.enumerated() {
            var rowItems: [YLCarPlateNoKeyBoardCellModel] = [];
            for (index, obj) in objArray.enumerated() {
                let model:YLCarPlateNoKeyBoardCellModel = YLCarPlateNoKeyBoardCellModel();
                model.text = obj;
                rowItems.append(model);
            }
            array.append(rowItems);
        }
        return array;
    }();
    
    lazy var noAndChars: [[YLCarPlateNoKeyBoardCellModel]] = {
        let provinces:[[String]] = [["1","2","3","4","5","6","7","8","9","0"],
                                    ["Q","W","E","R","T","Y","U","P","A","S"],
                                    ["D","F","G","H","J","K","L","Z","X"],
                                    ["C","V","B","N","M","港","澳","学","挂","delete"]];
        var array = [[YLCarPlateNoKeyBoardCellModel]]();
        for (idx, objArray) in provinces.enumerated() {
            var rowItems = [YLCarPlateNoKeyBoardCellModel]();
            for (index, obj) in objArray.enumerated() {
                let model: YLCarPlateNoKeyBoardCellModel = YLCarPlateNoKeyBoardCellModel();
                if (obj=="delete") {
                    model.isDeleteBtnType = true;
                    model.image = YLImageNamed("YLCarPlateNoKeyBoardView.bundle/rzDelete");
                } else {
                    model.text = obj;
                }
                rowItems.append(model);
            }
            array.append(rowItems);
        }
        return array;
    }();
    
    override init() {
        super.init();
        self.dataSource = self.provinces;
    }
    
    func regexPlateNo(plateNo: String) -> String {
        if (plateNo.length == 0) {
            return "";
        }
        var newText = "";
        // 1
        let province: String = plateNo.substring(rang: NSMakeRange(0, 1));
        var result: Bool = self.regexText(province, regex: province_Regex);
        if (result) {
            newText.append(province);
        }
        if (plateNo.length == 1) {
            return newText;
        }
        // 2
        let provinceCode: String = plateNo.substring(rang: NSMakeRange(1, 1));
        result = self.regexText(provinceCode, regex: province_code_Regex);
        if (result) {
            newText.append(provinceCode);
        }
        if (plateNo.length == 2) {
            return newText;
        }
        // 3
        let plateCode: String = plateNo.substring(rang: NSMakeRange(2, plateNo.length - 3));
        for index in 0 ..< plateCode.length {
            let temp: String = plateCode.substring(rang: NSMakeRange(index, 1));
            result = self.regexText(temp, regex: plateNo_code_Regex);
            if (result) {
                newText.append(temp);
            }
        }
        // 4
        let plateEnd: String = plateNo.substring(rang: NSMakeRange(plateNo.length - 1, 1));
        result = self.regexText(plateEnd, regex: plateNo_code_Regex);
        if (result) {
            newText.append(plateEnd);
        }
        return newText;
    }
    
    func regexText(_ text: String, regex: String) -> Bool {
        let regexText = String.init(format: "^%@{%ld}$", regex, text.length);
        let rs = NSPredicate.init(format: "SELF MATCHES %@", regexText);
        return rs.evaluate(with: text);
    }
    
    static var cityArray: Array<[String: String]>?;
    class func getAreaTitle(_ city: String) -> String {
        if cityArray == nil {
            let data: Data? = Data.dataWithPathName("YLCarPlateNoKeyBoardView.bundle/car_city.json");
            cityArray = data?.jsonObject() as? Array<[String : String]>;
        }
        guard cityArray?.count == 0 else {
            for dic in cityArray! {
                let temp = dic["city"]!;
                if city.contains(temp) || temp.contains(city) {
                    return dic["code"]!;
                }
            }
            return "";
        }
        return "";
    }
}
