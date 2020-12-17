//
//  String+Pinyin.swift
//  Driver
//
//  Created by ym on 2020/10/8.
//

import Foundation

extension String {
    /*
     *  获取该字符串的拼音,带声调,有空格
     *  @return 带声调的拼音字符串
     */
    func pinyinWithPhoneticSymbol () -> String {
        let pinyin = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(pinyin, nil, kCFStringTransformToLatin, false)
        return String(pinyin)
    }

    /*
     *  获取该字符串的拼音,不带声调,有空格
     *  @return 不带声调的拼音字符串
     */
    func pinyin () -> String {
        let pinyin = NSMutableString(string: self.pinyinWithPhoneticSymbol())
        //去掉拼音的音标
        CFStringTransform(pinyin, nil, kCFStringTransformStripDiacritics, false)
        return String(pinyin)
    }

    /*
     *  获取该字符串的拼音,带声调,有空格的集合
     *  @return Array
     */
    func pinyinArray () -> Array<String> {
        let array = self.pinyin().components(separatedBy: .whitespaces)
        return array;
    }

    /*
     *  获取该字符串的拼音,没声调,没空格
     *  @return 没声调的拼音字符串
     */
    func pinyinWithoutBlank() -> String {
        let string = NSMutableString("")
        for str in self.pinyinArray() {
            string.appending(str)
        }
        return String(string)
    }

    /*
     *  获取该字符串的首字母拼音集合
     *  @return Array
     */
    func pinyinInitialsArray () -> Array<String> {
        var array: [String] = [];
        for str in self.pinyinArray() {
            if str.length > 0 {
                array.append(str.substring(to: 1))
            }
        }
        return array
    }
    
    /*
     *  获取该字符串的首字母拼音
     *  @return 首拼音字符串
     */
    func pinyinInitialsString () -> String {
        let pinyin = NSMutableString("")
        for str in self.pinyinArray() {
            if str.length > 0 {
                pinyin.appending(str.substring(to: 1))
            }
        }
        return String(pinyin)
    }
}
