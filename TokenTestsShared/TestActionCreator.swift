//
//  TestActionCreator.swift
//  Token
//
//  Created by A.C. Wright Design on 11/9/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation
import Token

struct TestActionCreator: ActionCreator {
    
    func create(store: Store, state: State?, result: (Action?) -> Void) {
        if let state = state as? TestState {
            if state.counter == 1 {
                result(TestAction.decrease(amount: 1))
            } else {
                result(nil)
            }
        }
        
        result(nil)
    }
    
}
