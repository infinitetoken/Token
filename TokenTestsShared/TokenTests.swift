//
//  TokenTests.swift
//  TokenTests
//
//  Created by A.C. Wright Design on 11/8/17.
//  Copyright © 2017 Aaron Wright. All rights reserved.
//

import XCTest
@testable import Token

class TokenTests: XCTestCase {
    
    var token: Token!
    var subscriber: TestSubscriber!
    
    override func setUp() {
        super.setUp()
        
        let reducer = TestReducer()
        let state = TestState()
        let middleware: [Middleware] = []
        
        let token = Token(reducer: reducer, state: state, middleware: middleware)
        let subsciber = TestSubscriber()
        
        self.token = token
        self.subscriber = subsciber
    }
    
    override func tearDown() {
        self.token = nil
        
        super.tearDown()
    }

    func testCanInitialize() {
        XCTAssertNotNil(self.token)
        XCTAssertNotNil(self.token.state)
    }
    
    func testCanSubscribe() {
        self.token.subscribe(subscriber: self.subscriber)
        XCTAssertEqual(self.token.subscribers.count, 1)
    }
    
    func testCanUnsubscribe() {
        self.token.subscribe(subscriber: self.subscriber)
        self.token.unsubscribe(subscriber: self.subscriber)
        XCTAssertEqual(self.token.subscribers.count, 0)
    }
    
    func testCanDispatch() {
        let increaseAction = TestAction.increase(amount: 1)
        let decreaseAction = TestAction.decrease(amount: 1)
        
        self.token.dispatch(action: increaseAction)
        guard let state1 = self.token.state as? TestState else {
            XCTFail()
            return
        }
        XCTAssertEqual(state1.counter, 1)
        self.token.dispatch(action: decreaseAction)
        guard let state2 = self.token.state as? TestState else {
            XCTFail()
            return
        }
        XCTAssertEqual(state2.counter, 0)
    }

}
