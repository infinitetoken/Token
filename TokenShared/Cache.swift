//
//  Cache.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public struct Cache<T: Cacheable>: State {
    
    var cache: [Cacheable] = []
    
    public init() {}
    
}

extension Cache {
    
    func add(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.merge(cacheables) } }
    func merge(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.merge(cacheables) } }
    func remove(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.remove(cacheables) } }
    func clear() -> Cache<T> { return mutated { $0.cache = [] } }
    
}

extension Cache {
    
    public func items() -> [T] { return cache as! [T] }
    public func item(for UUID: UUID) -> T? { return cache.item(for: UUID) }
    
}
