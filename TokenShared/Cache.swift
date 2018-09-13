//
//  Cache.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public struct Cache<T: Cacheable>: State {
    
    var cache: [T]
    
    public init() {
        self.cache = []
    }
    
}

extension Cache {
    
    func add(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache = $0.cache.appending(cacheables) } }
    func merge(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache = $0.cache.merging(cacheables: cacheables) } }
    func remove(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache = $0.cache.removing(cacheables) } }
    func clear() -> Cache<T> { return mutated { $0.cache = [] } }
    
}

extension Cache {
    
    public func items() -> [T] { return cache }
    public func item(for UUID: String) -> T? { return cache.item(for: UUID) }
    public func item(atIndex index: Int) -> T? { return cache[index] }
    
}
