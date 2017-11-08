//
//  ActionCreator.swift
//  Token
//
//  Created by Aaron Wright on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public typealias ActionCreator<State> = (_ state: State, _ store: Store) -> Action?
