//
//  Token.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public class Token: Store {
    
    public var reducer: Reducer
    public var state: State?
    public var middleware: [Middleware]
    public var subscribers: [Subscriber] = []
    
    public required init(reducer: Reducer, state: State?, middleware: [Middleware]) {
        self.reducer = reducer
        self.state = state
        self.middleware = middleware
    }
    
    public func subscribe(subscriber: Subscriber) {
        self.subscribers.append(subscriber)
    }
    
    public func unsubscribe(subscriber: Subscriber) {
        if let index = self.subscribers.index(where: { return $0 === subscriber }) {
            self.subscribers.remove(at: index)
        }
    }
    
    public func dispatch(action: Action) {
        if self.middleware.count > 0 {
            let initial: MiddlewareResult = (self, action, self.state)
            if let result = self.middleware.reduce(initial, { (result, middleware) -> MiddlewareResult? in
                guard let result = result else { return nil }
                return middleware.execute(store: result.store, action: result.action, state: result.state)
            }) {
                self.state = self.reducer.reduce(action: result.action, state: result.state)
            }
        } else {
            self.state = self.reducer.reduce(action: action, state: self.state)
        }
        
        subscribers.forEach { $0.onChange(newState: self.state, action: action) }
    }
    
    public func dispatch(actionCreator: ActionCreator) {
        actionCreator.create(store: self, state: self.state) { (action: Action?) in
            guard let action = action else { return }
            self.dispatch(action: action)
        }
    }
}
