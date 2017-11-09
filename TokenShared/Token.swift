//
//  Token.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

struct Token: Store {
    
    var reducer: Reducer
    var state: State? {
        didSet {
            for subscriber in self.subscribers {
                subscriber.onChange(newState: self.state)
            }
        }
    }
    var middleware: [Middleware]
    var subscribers: [Subscriber] = []
    
    init(reducer: Reducer, state: State?, middleware: [Middleware]) {
        self.reducer = reducer
        self.state = state
        self.middleware = middleware
    }
    
    mutating func subscribe(subscriber: Subscriber) {
        self.subscribers.append(subscriber)
    }
    
    mutating func unsubscribe(subscriber: Subscriber) {
        // How to remove without Subscriber being Equatable? Or are we stuck with Equatable requirement here?
    }
    
    mutating func dispatch(action: Action) {
        self.state = self.reducer.reduce(action: action, state: self.state)
    }
    
    mutating func dispatch(actionCreator: ActionCreator) {
        if let action = actionCreator.create(state: self.state, store: self) {
            self.state = self.reducer.reduce(action: action, state: self.state)
        }
    }
    
}
