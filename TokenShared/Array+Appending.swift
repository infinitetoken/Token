//
//  Array+Appending.swift
//  Token
//
//  Created by Paul Foster on 1/21/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

internal extension Array {
    
    internal static func +(lhs: [Element], rhs: [Element]) -> [Element] { return lhs.appending(rhs) }
    internal static func +(lhs: [Element], rhs: Element) -> [Element] { return lhs.appending(rhs) }
    
    internal func appending(_ newElement: Element) -> [Element] {
        var result = self
        result.append(newElement)
        return result
    }
    
    internal func appending(_ contentsOf: [Element]) -> [Element] {
        var result = self
        result.append(contentsOf: contentsOf)
        return result
    }
    
}
