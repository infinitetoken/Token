//
//  TestMiddlewareActionChange.swift
//  Token
//
//  Created by A.C. Wright Design on 11/9/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation
import Token

struct TestMiddlewareActionChange: Middleware {
    
    func execute(store: Store, action: Action, state: State?) -> (Store, Action, State?)? {
        return (store, TestAction.decrease(amount: 1), state)
    }
    
}
