//
//  String+YLEncry.swift
//  Driver
//
//  Created by ym on 2020/10/5.
//

import Foundation
import CommonCrypto

extension String {
    /**
     *   md5 加密
     *   return 加密字符串
     */
    func md5() -> String! {
        let utf8_str = self.cString(using: .utf8)
        let str_len = CC_LONG(self.lengthOfBytes(using: .utf8))
        let digest_len = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digest_len)
        CC_MD5(utf8_str, str_len, result)
        let str = NSMutableString()
        for i in 0..<digest_len {
            str.appendFormat("%02x", result[i])
        }
        result.deallocate()
        return str as String
    }
    
    /**
     *   Base64 加密
     *   return 加密字符串
     */
    func encodeToBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else {
            print("加密失败"); return ""
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)) //系统提供的方法，iOS7之后可用
    }
    
    /**
     *   Base64 解密
     *   return 解密字符串
     */
    func decodeBase64() -> String {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            print("解密失败");
            return ""
        }
        return String(data: data, encoding: String.Encoding.utf8)!
    }
    
    func sha256() -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH));
        let data: Data = self.data(using: .utf8)!;
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, UInt32(data.count), &hash)
        }
        var sha256String = ""
        for byte in hash {
            sha256String += String(format:"%02x", UInt8(byte))
        }
        print("sha256 hash: \(sha256String)")
        return Data(hash)
    }
}
