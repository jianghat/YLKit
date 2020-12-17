//
//  NSDictionary+YLValueFormat.swift
//  Driver
//
//  Created by ym on 2020/10/10.
//

import Foundation

extension NSDictionary {
    func intForKey(_ key: Any) -> Int {
        var result: Int = 0;
        if let targetvalue = self.object(forKey: key) as? Int {
            result = targetvalue;
        } else if let targetvalue = self.object(forKey: key) as? String {
            result = Int(targetvalue) ?? 0;
        }
        return result;
    }
    
    func uint32ForKey(_ key: Any)->UInt32 {
        var result:UInt32 = 0;
        if let targetvalue:UInt32 = self.object(forKey: key) as? UInt32 {
            result = targetvalue;
        } else if let targetvalue = self.object(forKey: key) as? String {
            result = UInt32(targetvalue) ?? 0;
        }
        return result;
    }
    
    func floatForKey(_ key: Any) -> Float {
        var result:Float = 0;
        if let targetvalue:Float = self.object(forKey: key) as? Float {
            result = targetvalue;
        } else if let targetvalue = self.object(forKey: key) as? String {
            result = Float(targetvalue) ?? 0;
        }
        return result;
    }
    
    func doubleForKey(_ key: Any) -> Double {
        var result:Double = 0
        if let targetvalue:Double = self.object(forKey: key) as? Double {
            result = targetvalue;
        } else if let targetvalue = self.object(forKey: key) as? String {
            result = Double(targetvalue) ?? 0;
        }
        return result;
    }
    
    func boolForKey(_ key: Any) -> Bool {
        var result:Bool = false;
        if let targetvalue:Bool = self.object(forKey: key) as? Bool {
            result = targetvalue;
        }
        return result;
    }
    
    func stringForKey(_ key: Any) -> String {
        var result:String = "";
        if let targetvalue = self.object(forKey: key) as? String {
            result = targetvalue;
        }
        return result;
    }
    
    func toJsonString() -> String {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                     options: []) else {
            return "";
        }
        guard let str = String(data: data, encoding: .utf8) else {
            return "";
        }
        return str;
    }
}
