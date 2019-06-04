//
//  Array+Appending.swift
//  Token
//
//  Created by Paul Foster on 1/21/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension Array {
    
    internal static func +(lhs: [Element], rhs: [Element]) -> [Element] { return lhs.appending(rhs) }
    internal static func +(lhs: [Element], rhs: Element) -> [Element] { return lhs.appending(rhs) }
    
    func appending(_ newElement: Element) -> [Element] {
        var result = self
        result.append(newElement)
        return result
    }
    
    func appending(_ contentsOf: [Element]) -> [Element] {
        var result = self
        result.append(contentsOf: contentsOf)
        return result
    }
    
}
