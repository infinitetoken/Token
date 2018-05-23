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
    public func items(for uuids: [String]) -> [Element] { return filter { uuids.contains($0.uuid) } }
    
    public func contains(_ cacheable: Element) -> Bool { return uuids().contains(cacheable.uuid)  }
    
    public func item<T: Cacheable>(for UUID: String) -> T? {
        return reduce(nil, { (result, cacheable) -> T? in
            if let result = result { return result }
            if cacheable.uuid != UUID { return nil }
            return cacheable as? T
        })
    }
    
    public func item(for UUID: String) -> Element? {
        return reduce(nil, { (result, cacheable) -> Element? in
            if let result = result { return result }
            if cacheable.uuid != UUID { return nil }
            return cacheable
        })
    }
    
    // MARK: - Maps
    
    public func merging(_ cacheable: Element) -> [Element] {
        var found: Bool = false
        
        let result: [Element] = map {
            if $0 == cacheable {
                found = true
                return cacheable
            } else {
                return $0
            }
        }
        
        if !found { return result.appending(cacheable) } else { return result }
    }
    
    public func merging(_ cacheable: [Element]) -> [Element] {
        var result = self
        result.merge(cacheable)
        return result
    }
        
    public func removing(_ Cacheable: Element) -> [Element] { return filter { $0 != Cacheable } }
    public func removing(_ cacheable: [Element]) -> [Element] { return filter { !cacheable.contains($0) } }
    
    // MARK: - Mutations
    
    public mutating func remove(_ cacheable: [Element]) { self = removing(cacheable) }
    public mutating func remove(_ cacheable: Element) { self = removing(cacheable) }
    public mutating func merge(_ cacheable: Element) { self = merging(cacheable) }
    public mutating func merge(_ cacheable: [Element]) { cacheable.forEach { self.merge($0) } }
    
}
