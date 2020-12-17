//
//  NSData+YLAdd.swift
//  Driver
//
//  Created by ym on 2020/10/28.
//

import Foundation

extension Data {
    static func dataWithPathName(_ name: String) -> Data? {
        let path: String? = Bundle.main.path(forResource: name, ofType: nil);
        guard (path != nil) else { return nil }
        let url = URL(fileURLWithPath: path!)
        let jsonData = try? Data(contentsOf: url);
        return jsonData;
    }
    
    func jsonObject() -> Any? {
        do {
            let rs = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableLeaves);
            return rs
        } catch {
            return nil;
        }
    }
}
