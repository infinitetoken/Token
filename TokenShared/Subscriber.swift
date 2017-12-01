//
//  Subscriber.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol Subscriber: class {
    func onChange(newState: State?, action: Action) -> Void
}


public extension Subscriber {
    public func subscribe() {
        Token.shared.subscribe(subscriber: self)
    }
    
    public func unsubscribe() {
        Token.shared.unsubscribe(subscriber: self)
    }
    
    public func dispatch(_ action: Action) {
        Token.shared.dispatch(action: action)
    }
    
    public func dispatch(_ actionCreator: ActionCreator) {
        Token.shared.dispatch(actionCreator: actionCreator)
    }
}
