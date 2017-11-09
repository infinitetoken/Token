//
//  ActionCreator.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol ActionCreator {
    func create(state: State?, store: Store) -> Action?
}
