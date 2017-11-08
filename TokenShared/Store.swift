//
//  Store.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol Store {
    
    var state: State! { get }
    var dispatchFunction: DispatchFunction! { get }
    
    func subscribe<S: Subscriber>(_ subscriber: S) -> Void
    func subscribe<S: Subscriber>(_ subscriber: S, transform: ((State) -> State)?) -> Void
    func unsubscribe(_ subscriber: Subscriber) -> Void
    func dispatch(_ action: Action) -> Void
    func dispatch<T: State>(_ actionCreator: ActionCreator<T>) -> Void
    
}
