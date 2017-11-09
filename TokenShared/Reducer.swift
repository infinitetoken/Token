//
//  Reducer.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol Reducer {
    func reduce(action: Action, state: State?) -> State
}
