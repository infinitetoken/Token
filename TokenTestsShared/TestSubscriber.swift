//
//  TestSubscriber.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation
import Token

class TestSubscriber: Subscriber {
    
    var label: Int = 0
    
    func onChange(newState: State?, action: Action) {
        if let state = newState as? TestState {
            self.label = state.counter
        }
    }
    
}
