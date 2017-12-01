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
    
    public var token: Token {
       return Token.shared
    }
    
    public func subscribe() {
        token.subscribe(subscriber: self)
    }
    
    public func unsubscribe() {
        token.unsubscribe(subscriber: self)
    }
    
    public func dispatch(_ action: Action) {
        token.dispatch(action: action)
    }
    
    public func dispatch(_ actionCreator: ActionCreator) {
        token.dispatch(actionCreator: actionCreator)
    }
}
