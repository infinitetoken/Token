//
//  Reducer.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public typealias Reducer<State> = (_ action: Action, _ state: State?) -> State
