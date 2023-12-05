//
//  Subscriber.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol Subscriber: AnyObject {
    
    func onChange(newState: State?, action: Action) -> Void
    
}

public extension Subscriber {
    
    var token: Token { return Token.shared }
    
    func dispatch(_ action: Action, token: Token = Token.shared) { token.dispatch(action: action) }
    func dispatch(_ actionCreator: ActionCreator, token: Token = Token.shared) { token.dispatch(actionCreator: actionCreator) }
    
    func subscribe(token: Token = Token.shared) { token.subscribe(subscriber: self) }
    func unsubscribe(token: Token = Token.shared) { token.unsubscribe(subscriber: self) }
    
    func onChange(newState: State?, action: Action) {}
    
}
