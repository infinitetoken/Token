//
//  Array+cacheable.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public extension Array where Element: Cacheable {
    
    // MARK: - Getters
    
    func uuids() -> [String] { return map { $0.uuid } }
    func items(for uuids: [String]) -> [Element] { return filter { uuids.contains($0.uuid) } }
    
    func contains(_ cacheable: Element) -> Bool { return uuids().contains(cacheable.uuid)  }
    
    func item(for UUID: String) -> Element? {
        return reduce(nil, { (result, cacheable) -> Element? in
            if let result = result { return result }
            if cacheable.uuid != UUID { return nil }
            return cacheable
        })
    }
    
    // MARK: - Maps
    
    func merging(_ cacheable: Element) -> [Element] {
//        var found: Bool = false
//
//        let result: [Element] = map {
//            if $0 == cacheable {
//                found = true
//                return cacheable
//            } else {
//                return $0
//            }
//        }
//
//        if !found { return result.appending(cacheable) } else { return result }
        
        let result: [Element] = filter { (element) -> Bool in
            return element != cacheable
        }
        
        return result.appending(cacheable)
    }
    
    func merging(cacheables: [Element]) -> [Element] {
        var result = self
        result.merge(cacheables)
        return result
    }
        
    func removing(_ cacheable: Element) -> [Element] { return filter { $0 != cacheable } }
    func removing(_ cacheable: [Element]) -> [Element] { return filter { !cacheable.contains($0) } }
    
    // MARK: - Mutations
    
    mutating func remove(_ cacheable: [Element]) { self = removing(cacheable) }
    mutating func remove(_ cacheable: Element) { self = removing(cacheable) }
    mutating func merge(_ cacheable: Element) { self = merging(cacheable) }
    mutating func merge(_ cacheable: [Element]) { cacheable.forEach { self.merge($0) } }
    
}
