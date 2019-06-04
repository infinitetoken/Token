//
//  TestWidget.swift
//  Token
//
//  Created by Aaron Wright on 12/24/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import Foundation
import Token

struct TestWidget: Cacheable {
    
    var uuid: String
    
    init(uuid: String = UUID().uuidString) {
        self.uuid = uuid
    }
    
}
