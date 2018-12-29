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
        
        let token = Token()
        token.reducer = reducer
        token.state = state
        token.middleware = middleware
        
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
        let subscriber1 = TestSubscriber()
        
        self.token.subscribe(subscriber: subscriber1)
        
        XCTAssertEqual(self.token.subscribers.count, 1)
        
        self.token.subscribe(subscriber: subscriber1)
        
        XCTAssertEqual(self.token.subscribers.count, 1)
    }
    
    func testCanUnsubscribe() {
        let subscriber1 = TestSubscriber()
        let subscriber2 = TestSubscriber()
        
        self.token.subscribe(subscriber: subscriber1)
        self.token.subscribe(subscriber: subscriber2)
        
        XCTAssertEqual(self.token.subscribers.count, 2)
        
        self.token.unsubscribe(subscriber: subscriber1)
        
        XCTAssertEqual(self.token.subscribers.count, 1)
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
    
    func testCanDispatchActionCreator() {
        let actionCreator = TestActionCreator()
        
        self.token.dispatch(actionCreator: actionCreator)
        guard let state0 = self.token.state as? TestState else {
            XCTFail()
            return
        }
        XCTAssertEqual(state0.counter, 0)
        
        let increaseAction = TestAction.increase(amount: 1)
        
        self.token.dispatch(action: increaseAction)
        guard let state1 = self.token.state as? TestState else {
            XCTFail()
            return
        }
        XCTAssertEqual(state1.counter, 1)
        
        self.token.dispatch(actionCreator: actionCreator)
        guard let state2 = self.token.state as? TestState else {
            XCTFail()
            return
        }
        XCTAssertEqual(state2.counter, 0)
    }
    
    func testSubscriberCanBeNotified() {
        self.token.subscribe(subscriber: self.subscriber)
        XCTAssertEqual(self.token.subscribers.count, 1)
        XCTAssertEqual(self.subscriber.label, 0)
        
        let increaseAction = TestAction.increase(amount: 1)
        
        self.token.dispatch(action: increaseAction)
        
        XCTAssertEqual(self.subscriber.label, 1)
        
        self.token.dispatch(action: increaseAction)
        
        XCTAssertEqual(self.subscriber.label, 2)
    }
    
    func testMiddlewareCanChangeAction() {
        self.token.middleware = [TestMiddlewareActionChange()]
        
        let increaseAction = TestAction.increase(amount: 1)
        
        self.token.dispatch(action: increaseAction)
        
        guard let state = self.token.state as? TestState else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(state.counter, -1)
    }
    
    func testCacheableEquatable() {
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        let widget3 = TestWidget(uuid: "2")
        
        XCTAssertTrue(widget1 != widget2)
        XCTAssertTrue(widget2 == widget3)
    }
    
    func testSubscriber() {
        let token = Token()
        let subscriber = TestSubscriber()
        
        subscriber.subscribe(token: token)
        
        XCTAssertEqual(token.subscribers.count, 1)
        
        subscriber.unsubscribe(token: token)
        
        XCTAssertEqual(token.subscribers.count, 0)
    }
    
    func testSubscriberCanGetSharedToken() {
        let subscriber = TestSubscriber()
        let token = subscriber.token
        
        XCTAssertNotNil(token)
    }
    
    func testSubscriberCanDispatchAction() {
        self.subscriber.dispatch(TestAction.increase(amount: 1), token: self.token)
        
        guard let newState = self.token.state as? TestState else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(newState.counter, 1)
    }
    
    func testSubscriberCanDispatchActionCreator() {
        self.subscriber.dispatch(TestActionCreator(), token: self.token)
        
        guard let newState = self.token.state as? TestState else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(newState.counter, 0)
    }
    
    func testSubscriberHasOptionalOnChangeFunction() {
        let subscriber = TestSubscriberWithoutOnChange()
        subscriber.subscribe(token: self.token)
        subscriber.dispatch(TestAction.increase(amount: 1), token: self.token)
        
        XCTAssertNotNil(subscriber)
    }
    
}
