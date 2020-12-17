//
//  String+YLMatch.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import Foundation

extension String {
    /*
     *  @brief  返回正则表达式所匹配到的String集合
     *
     *  @param regex 正则表达式
     *
     *  @return Array
     */
    func matchWithRegex(_ regex: String) -> Array<String> {
        let result = self.firstMatchedResultWithRegex(regex);
        var mArray: [String] = []
        let r = self as NSString
        for index in 0..<result.numberOfRanges {
            let range = result.range(at: index)
            mArray.append(r.substring(with: range))
        }
        return mArray
    }
    
    /*
     *  @brief  返回正则表达式所匹配到的String
     *
     *  @param regex 正则表达式
     *  @param index 获取String集合中的第几个元素
     *
     *  @return String
     */
    func matchWithRegex(_ regex: String, index: Int) -> String {
        let result = self.firstMatchedResultWithRegex(regex);
        let r: NSString = self as NSString
        return r.substring(with: result.range(at: index))
    }
    
    /*!
     *  @brief  返回正则表达式所匹配到的String
     *
     *  @param regex 正则表达式
     *
     *  @return 获取String集合中的第1个元素
     */
    func firstMatchedGroupWithRegex(_ regex: String) -> String {
        return self.matchWithRegex(regex, index: 0)
    }
    
    /*!
     *  @brief  返回正则表达式所匹配到的String
     *
     *  @param regex 正则表达式
     *
     *  @return 获取String集合中的最后1个元素
     */
    func lastMatchedGroupWithRegex(_ regex: String) -> String {
        let array = self.matchWithRegex(regex)
        return array.last ?? ""
    }


    /*
     *  @brief  返回包含正则表达式所匹配到的NSString的NSTextCheckingResult对象
     *
     *  @param regex 正则表达式
     *
     *  @return NSTextCheckingResult对象
     */
    func firstMatchedResultWithRegex(_ regex: String) -> NSTextCheckingResult {
        let regexExpression = try! NSRegularExpression.init(pattern: regex, options: [])
        let range = NSRange(location: 0, length: self.length)
        return regexExpression.firstMatch(in: self, options: [], range: range)!
    }
    
    /*
     *  @brief  返回pattern所匹配到的NSTextCheckingResult集合
     *
     *  @param regex 正则表达式
     *
     *  @return Array
     */
    func matchsWithPattern(_ pattern: String) -> Array<NSTextCheckingResult> {
        let regex = try! NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.length)
        let array = regex.matches(in: self, options:NSRegularExpression.MatchingOptions.init(rawValue: 0), range: range)
        return array
    }
}
