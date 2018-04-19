//
//  Array+Cacheable.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension Array where Element == Cacheable {
    
    // MARK: - Getters
    
    public func uuids() -> [UUID] { return map { $0.uuid } }
    public func items<T: Cacheable>() -> [T] { return compactMap { $0 as? T } }
    public func items(for uuids: [UUID]) -> [Cacheable] { return filter { uuids.contains($0.uuid) } }
    
    public func contains(_ Cacheable: Cacheable) -> Bool { return uuids().contains(Cacheable.uuid)  }
    
    public func item<T: Cacheable>(for UUID: UUID) -> T? {
        return reduce(nil, { (result, Cacheable) -> T? in
            if let result = result { return result }
            if Cacheable.uuid != UUID { return nil }
            return Cacheable as? T
        })
    }
    
    public func item(for UUID: UUID) -> Cacheable? {
        return reduce(nil, { (result, Cacheable) -> Cacheable? in
            if let result = result { return result }
            if Cacheable.uuid != UUID { return nil }
            return Cacheable
        })
    }
    
    // MARK: - Maps
    
    internal func merging(_ Cacheable: Cacheable) -> [Cacheable] {
        var found: Bool = false
        
        let result: [Cacheable] = map {
            if $0 == Cacheable {
                found = true
                return Cacheable
            } else {
                return $0
            }
        }
        
        if !found { return result.appending(Cacheable) } else { return result }
    }
    
    internal func merging(_ Cacheables: [Cacheable]) -> [Cacheable] {
        var result = self
        result.merge(Cacheables)
        return result
    }
        
    internal func removing(_ Cacheable: Cacheable) -> [Cacheable] { return filter { $0 != Cacheable } }
    internal func removing(_ Cacheables: [Cacheable]) -> [Cacheable] { return filter { !Cacheables.contains($0) } }
    
    // MARK: - Mutations
    
    internal mutating func remove(_ Cacheables: [Cacheable]) { self = removing(Cacheables) }
    internal mutating func remove(_ Cacheable: Cacheable) { self = removing(Cacheable) }
    internal mutating func merge(_ Cacheable: Cacheable) { self = merging(Cacheable) }
    internal mutating func merge(_ Cacheables: [Cacheable]) { Cacheables.forEach { self.merge($0) } }
    
}
