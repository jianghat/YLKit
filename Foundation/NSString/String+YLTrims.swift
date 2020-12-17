//
//  NSString+YLTrims.swift
//  Driver
//
//  Created by ym on 2020/9/27.
//

import Foundation

extension String {
    func replacingRegex(_ regex: String, options: NSRegularExpression.Options = [], replacement: String) -> String {
        let pattern: NSRegularExpression? = try! NSRegularExpression.init(pattern: regex, options: options)
        if pattern == nil {
            return self
        }
        return pattern!.stringByReplacingMatches(in: self, options: [], range: NSRange.init(location: 0, length: self.length), withTemplate: replacement)
    }
    
    /** 去掉html标签 */
    func stringByStrippingHTML() -> String {
        return self.replacingRegex("<[^>]+>", options: [], replacement: "" )
    }

    /** 去掉html标签跟script标签 */
    func stringByRemovingScriptsAndStrippingHTML() -> String {
        let mString: NSMutableString = self.mutableCopy() as! NSMutableString
        let regex = try? NSRegularExpression.init(pattern: "<script[^>]*>[\\w\\W]*</script>", options:.caseInsensitive)
        
        let matches = regex?.matches(in: mString as String, options:.reportProgress, range: NSRange(location: 0, length: mString.length))
        if matches?.count > 0 {
            for match in matches!.reversed() {
                mString.replacingCharacters(in: match.range, with: "")
            }
        }
        return String(mString).stringByStrippingHTML()
    }
    
    //MARK:去掉左右空格
    func trim() -> String! {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /** 去掉两端空格,不包括回车 */
    func trimmingWhitespace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    /** 去掉两端空格,包括回车 */
    func trimmingWhitespaceAndNewlines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimmingAllWhitespace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    
    /**
     将字符串替换*号
     - parameter str:        字符
     - parameter startindex: 开始字符索引
     - parameter endindex:   结束字符索引
     - returns: 替换后的字符串
     */
    func stringByX(startIndex:Int, endIndex:Int) -> String {
        //开始字符索引
        let startindex = self.index(self.startIndex, offsetBy: startIndex);
        //结束字符索引
        let end = min(self.length, endIndex);
        let endindex = self.index(self.startIndex, offsetBy: end);
        var s = String()
        for _ in 0..<end - startIndex {
            s += "*"
        }
        let result = self.replacingCharacters(in: startindex..<endindex, with: s)
        return result;
    }
}
