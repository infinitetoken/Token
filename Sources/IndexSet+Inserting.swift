//
//  IndexSet+Inserting.swift
//  Token
//
//  Created by Paul Foster on 1/17/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension IndexSet {
    
    func inserting(_ integer: Int) -> IndexSet {
        var set = self
        set.insert(integer)
        return set
    }
    
    func inserting(_ integers: [Int]) -> IndexSet {
        var set = self
        integers.forEach { set = set.inserting($0) }
        return set
    }
    
}
