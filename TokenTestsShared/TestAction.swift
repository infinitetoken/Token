//
//  TestAction.swift
//  Token
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation
import Token

enum TestAction: Action {
    case increase(amount: Int)
    case decrease(amount: Int)
}
