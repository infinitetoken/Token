//
//  CacheAction.swift
//  Token
//
//  Created by Paul Foster on 1/31/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import Foundation

public enum CacheAction<T>: Action where T: Cacheable {
    case add([T])
    case merge([T])
    case remove([T])
    case clear
    case error(Error?)
}

