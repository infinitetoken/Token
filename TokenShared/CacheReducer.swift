//
//  CacheReducer.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public struct CacheReducer<A>: Reducer where A : Cacheable {
    
    public init() {}
    
    public func reduce(action: Action, state: State?) -> State? {
        guard let action = action as? CacheAction<A> else { return state }
        guard let newState = state as? Cache<A> else { return state }
        
        switch action {
        case .add(let cacheables): return newState.add(cacheables)
        case .remove(let cacheables): return newState.remove(cacheables)
        case .clear: return newState.clear()
        case .error(_): return newState
        }
    }
    
}
