//
//  Array+cacheable.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension Array where Element == Cacheable {
    
    // MARK: - Getters
    
    public func uuids() -> [String] { return map { $0.uuid } }
    public func items<T: Cacheable>() -> [T] { return compactMap { $0 as? T } }
    public func items(for uuids: [String]) -> [Cacheable] { return filter { uuids.contains($0.uuid) } }
    
    public func contains(_ cacheable: Cacheable) -> Bool { return uuids().contains(cacheable.uuid)  }
    
    public func item<T: Cacheable>(for UUID: String) -> T? {
        return reduce(nil, { (result, cacheable) -> T? in
            if let result = result { return result }
            if cacheable.uuid != UUID { return nil }
            return cacheable as? T
        })
    }
    
    public func item(for UUID: String) -> Cacheable? {
        return reduce(nil, { (result, cacheable) -> Cacheable? in
            if let result = result { return result }
            if cacheable.uuid != UUID { return nil }
            return cacheable
        })
    }
    
    // MARK: - Maps
    
    public func merging(_ cacheable: Cacheable) -> [Cacheable] {
        var found: Bool = false
        
        let result: [Cacheable] = map {
            if $0 == cacheable {
                found = true
                return cacheable
            } else {
                return $0
            }
        }
        
        if !found { return result.appending(cacheable) } else { return result }
    }
    
    public func merging(_ cacheable: [Cacheable]) -> [Cacheable] {
        var result = self
        result.merge(cacheable)
        return result
    }
        
    public func removing(_ Cacheable: Cacheable) -> [Cacheable] { return filter { $0 != Cacheable } }
    public func removing(_ cacheable: [Cacheable]) -> [Cacheable] { return filter { !cacheable.contains($0) } }
    
    // MARK: - Mutations
    
    public mutating func remove(_ cacheable: [Cacheable]) { self = removing(cacheable) }
    public mutating func remove(_ cacheable: Cacheable) { self = removing(cacheable) }
    public mutating func merge(_ cacheable: Cacheable) { self = merging(cacheable) }
    public mutating func merge(_ cacheable: [Cacheable]) { cacheable.forEach { self.merge($0) } }
    
}
