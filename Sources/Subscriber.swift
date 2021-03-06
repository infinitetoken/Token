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
    
    func onChange(newState: State?, action: Action) {}
    
}
