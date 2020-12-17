//
//  YLValid.swift
//  Driver
//
//  Created by ym on 2020/9/29.
//

import Foundation

extension String {
    func validateByRegex(_ regex: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluate(with: self)
    }
    
    /**
     *  网址有效性
     */
    func isValidURL() -> Bool {
        let regex = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$"
        return self.validateByRegex(regex)
    }
    
    /**
     *  邮箱
     */
    func isEmailAddress() -> Bool {
        let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.validateByRegex(regex)
    }
    
    /**
     *  身份证
     */
    func isIDCardNumber() -> Bool {
        let regex = "^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|xX)$";
        return self.validateByRegex(regex);
    }
    
    /**
     *  判断字符串是否为空
     */
    func isNullOrEmpty() -> Bool {
        return self.trimmingWhitespaceAndNewlines().length == 0
    }
    
    /**
     *  判断字符串是否为整型
     */
    func isPureInt() -> Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /**
     *  判断是否为浮点型
     */
    func isPureFloat() -> Bool {
        let scan = Scanner.init(string: self)
        var val: Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /**
     *  判断是否为纯汉字
     */
    func isPureChinese() -> Bool {
        let regex: String = "[\\u4e00-\\u9fa5]+$"
        return self.validateByRegex(regex);
    }
    
    /**
     *  判断是否为表情符号
     */
    func isContainsEmoji() -> Bool {
        let regex = "[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]";
        return self.validateByRegex(regex);
    }
}

