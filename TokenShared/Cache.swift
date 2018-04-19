//
//  Cache.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public struct Cache<T: Cacheable>: State {
    
    var cache: [Cacheable]
    var selected: [Cacheable]
    
    public init() {
        self.cache = []
        self.selected = []
    }
    
}

extension Cache {
    
    func selectAndReplace(_ cacheables: [T]) -> Cache<T> { return mutated { $0.selected = cacheables } }
    func selectAndMerge(_ cacheables: [T]) -> Cache<T> { return mutated { $0.selected.merge(cacheables) } }
    func selectAll() -> Cache<T> { return mutated { $0.selected.merge(cache) } }
    func deselect(_ cacheables: [T]) -> Cache<T> { return mutated { $0.selected.remove(cacheables) } }
    func deselectAll() -> Cache<T> { return mutated { $0.selected = [] } }
    func add(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.merge(cacheables) } }
    func merge(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.merge(cacheables) } }
    func remove(_ cacheables: [T]) -> Cache<T> { return mutated { $0.cache.remove(cacheables) } }
    func clear() -> Cache<T> { return mutated { $0.cache = [] } }
    
    func selectPrevious() -> Cache<T> {
        var indexes: [Int] = []
        for (index, item) in self.cache.enumerated() {
            if self.selected.contains(item) {
                indexes.append(index)
            }
        }
        
        return mutated {
            $0.selected = indexes.map({ (index) -> Cacheable in
                let newIndex = index - 1 == -1 ? self.cache.endIndex - 1 : index - 1
                return self.cache[newIndex]
            })
        }
    }
    
    func selectNext() -> Cache<T> {
        var indexes: [Int] = []
        for (index, item) in self.cache.enumerated() {
            if self.selected.contains(item) {
                indexes.append(index)
            }
        }
        
        return mutated {
            $0.selected = indexes.map({ (index) -> Cacheable in
                let newIndex = index + 1 == self.cache.count ? self.cache.startIndex : index + 1
                return self.cache[newIndex]
            })
        }
    }
    
}

extension Cache {
    
    public func cachedItems() -> [T] { return cache as! [T] }
    public func item(for UUID: UUID) -> T? { return cache.item(for: UUID) }
    public func selectedUUIDs() -> [UUID] { return selected.uuids() }
    public func deselectedUUIDs() -> [UUID] { return deselectedItems().map { $0.uuid } }
    public func selectedItems() -> [T] { return selected as! [T] }
    public func selectedItem() -> T? { return selectedItems().first }
    public func deselectedItems() -> [T] { return cache.removing(selected) as! [T] }
    
    public func selectedIndexes(in sequence: [T]) -> IndexSet {
        return sequence.enumerated().reduce(IndexSet()) {
            guard selected.contains($1.element) else { return $0 }
            return $0.inserting($1.offset)
        }
    }
    
    public func deselectedIndexes(in sequence: [T]) -> IndexSet {
        return sequence.enumerated().reduce(IndexSet()) {
            guard !selected.contains($1.element) else { return $0 }
            return $0.inserting($1.offset)
        }
    }
    
    public func selectedIndexes() -> IndexSet {
        return cache.enumerated().reduce(IndexSet()) {
            guard selected.contains($1.element) else { return $0 }
            return $0.inserting($1.offset)
        }
    }

    public func deselectedIndexes() -> IndexSet {
        return cache.enumerated().reduce(IndexSet()) {
            guard !selected.contains($1.element) else { return $0 }
            return $0.inserting($1.offset)
        }
    }
    
}
