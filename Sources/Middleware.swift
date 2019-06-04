//
//  Middleware.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public typealias MiddlewareResult = (store: Store, action: Action, state: State?)

public protocol Middleware {
    
    func execute(store: Store, action: Action, state: State?) -> MiddlewareResult
    
}
