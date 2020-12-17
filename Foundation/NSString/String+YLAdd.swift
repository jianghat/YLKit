//
//  NSString+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import Foundation

extension String {
    //32位长度uuid
    static var UUID: String {
        let uuidRef = CFUUIDCreate(nil);
        let uuidStringRef = CFUUIDCreateString(nil,uuidRef);
        return uuidStringRef! as String;
    }
    
    var length: Int {
        return self.count;
    }
    
    func floatValue() -> CGFloat {
        if let doubleValue = Double(self) {
            return CGFloat(doubleValue)
        }
        return 0.0
    }
    
    func intValue() -> Int {
        if let doubleValue = Double(self) {
            return Int(doubleValue)
        }
        return 0
    }
    
    func dataValue() -> Data? {
        return self.data(using: .utf8);
    }
    
    func jsonObject() -> Any {
        return self.dataValue()?.jsonObject() as Any;
    }
    
    func toURL() -> URL? {
        return URL(string: self);
    }
    
    /// 截取字符
    /// - Parameter index: 位置
    /// - Returns: 字符
    func characterAtIndex(_ index: Int) -> Character? {
        var currentIndex = 0
        for char in self {
            if currentIndex == index {
                return char
            }
            currentIndex+=1;
        }
        return nil
    }
    
    /// 十进制转十六进制
    /// - Returns: 十六进制字符串
    func decimalToHex() -> String {
        return String(self.intValue(), radix: 16);
    }
    
    /// 十进制转十六进制
    /// - Parameter lenght: 总长度，不足补0
    /// - Returns: 十六进制字符串
    func decimalToHexWithLength(lenght: Int) -> String {
        var subString = String(self.intValue(), radix: 16);
        let moreL = length - subString.length;
        if (moreL>0) {
            for _ in 0 ..< moreL {
                subString += "0";
            }
        }
        return subString;
    }
    
    /// 解析URL参数
    /// - Parameters:
    ///   - key: 想要获取参数的名字
    ///   - url: url地址
    /// - Returns: 对应参数的值
    func urlParamForKey(_ key: String, url: String) -> String {
        let regTags = String(format: "(^|&|\\?)+%@=+([^&]*)(&|$)", key);
        let regex = try? NSRegularExpression.init(pattern: regTags, options: .caseInsensitive);
        if let regex = regex {
            let matches: [NSTextCheckingResult] =  regex.matches(in: url, options: .reportProgress, range: NSRange(location: 0, length: url.length));
            for match in matches {
                return url .substring(rang: match.range(at: 2));
            }
        }
        return "";
    }
}
