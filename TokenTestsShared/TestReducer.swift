//
//  TestReducer.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation
import Token

struct TestReducer: Reducer {
    
    func reduce(action: Action, state: State?) -> State? {
        if let action = action as? TestAction, var state = state as? TestState {
            switch action {
            case .increase(let amount):
                state.counter += amount
            case .decrease(let amount):
                state.counter -= amount
            }
            return state
        }
        return nil
    }
    
}
