//
//  Store.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol Store {
    
    var reducer: Reducer? { get }
    var state: State? { get }
    var middleware: [Middleware] { get set }
    var subscribers: [Subscriber] { get set }
    
    mutating func subscribe(subscriber: Subscriber) -> Void
    mutating func unsubscribe(subscriber: Subscriber) -> Void
    mutating func dispatch(action: Action) -> Void
    mutating func dispatch(actionCreator: ActionCreator) -> Void
    
}
