//
//  StateMutatedTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/14/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import XCTest
@testable import Token

class StateMutatedTests: XCTestCase {
    
    struct TestState: State {
        var foo: String
    }

    func testMutated() {
        var testState = TestState(foo: "bar")
        
        XCTAssertEqual(testState.foo, "bar")
        
        testState = testState.mutated {
            return $0.foo = "baz"
        }
        
        XCTAssertEqual(testState.foo, "baz")
    }
    
}
