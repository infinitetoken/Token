//
//  ArrayReducer.swift
//  Token
//
//  Created by A.C. Wright Design on 12/26/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import Foundation

public protocol ArrayReducer {
    func reduce(action: Action, state: [State]) -> [State]
}
