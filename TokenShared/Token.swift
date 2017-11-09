//
//  Token.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public struct Token: Store {
    
    public var reducer: Reducer
    public var state: State? {
        didSet {
            for subscriber in self.subscribers {
                subscriber.onChange(newState: self.state)
            }
        }
    }
    public var middleware: [Middleware]
    public var subscribers: [Subscriber] = []
    
    public init(reducer: Reducer, state: State?, middleware: [Middleware]) {
        self.reducer = reducer
        self.state = state
        self.middleware = middleware
    }
    
    mutating public func subscribe(subscriber: Subscriber) {
        self.subscribers.append(subscriber)
    }
    
    mutating public func unsubscribe(subscriber: Subscriber) {
        // How to remove without Subscriber being Equatable? Or are we stuck with Equatable requirement here?
    }
    
    mutating public func dispatch(action: Action) {
        self.state = self.reducer.reduce(action: action, state: self.state)
    }
    
    mutating public func dispatch(actionCreator: ActionCreator) {
        if let action = actionCreator.create(state: self.state, store: self) {
            self.state = self.reducer.reduce(action: action, state: self.state)
        }
    }
    
}
