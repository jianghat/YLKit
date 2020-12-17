//
//  ss.swift
//  Driver
//
//  Created by ym on 2020/11/5.
//

import Foundation

//Swift 升级至 3.0 以后，Swift 标准库中移除了对可选类型比较运算符的实现，当我们升级 Swift 版本的时候，可能会出现若干问题，为了代码重构需要，所以重写比较运算符。
func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool
{
    switch (lhs, rhs)
    {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool
{
    switch (lhs, rhs)
    {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}
