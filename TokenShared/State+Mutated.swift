//
//  State+Mutated.swift
//  Token
//
//  Created by Paul Foster on 1/9/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension State {
    
    func mutated(_ morphism: (inout Self) -> ()) -> Self {
        var result = self
        morphism(&result)
        return result
    }
    
}
