//
//  Cacheable.swift
//  Token
//
//  Created by A.C. Wright Design on 4/19/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import Foundation

public func !=(lhs: Cacheable, rhs: Cacheable) -> Bool { return lhs.uuid != rhs.uuid }
public func ==(lhs: Cacheable, rhs: Cacheable) -> Bool { return lhs.uuid == rhs.uuid }

public protocol Cacheable {
    
    var uuid: String { get set }
    
}
