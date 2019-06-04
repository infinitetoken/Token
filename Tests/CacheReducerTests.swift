//
//  CacheReducerTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/19/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import XCTest
@testable import Token

class CacheReducerTests: XCTestCase {

    func testCanAdd() {
        let cache = Cache<TestWidget>()
        let reducer = CacheReducer<TestWidget>()
        
        let widget = TestWidget()
        
        guard let state = reducer.reduce(action: CacheAction.add([widget]), state: cache) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(state.items().count, 1)
    }
    
    func testCanMerge() {
        let cache = Cache<TestWidget>()
        let reducer = CacheReducer<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        let widget3 = TestWidget(uuid: "3")
        
        guard let initialState = reducer.reduce(action: CacheAction.add([widget1, widget2]), state: cache) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(initialState.items().count, 2)
        
        guard let nextState = reducer.reduce(action: CacheAction.merge([widget1]), state: initialState) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(nextState.items().count, 2)
        
        guard let finalState = reducer.reduce(action: CacheAction.merge([widget3]), state: nextState) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(finalState.items().count, 3)
    }
    
    func testCanRemove() {
        let cache = Cache<TestWidget>()
        let reducer = CacheReducer<TestWidget>()
        
        let widget = TestWidget()
        
        guard let initialState = reducer.reduce(action: CacheAction.add([widget]), state: cache) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        guard let nextState = reducer.reduce(action: CacheAction.remove([widget]), state: initialState) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(initialState.items().count, 1)
        XCTAssertEqual(nextState.items().count, 0)
    }
    
    func testCanClear() {
        let cache = Cache<TestWidget>()
        let reducer = CacheReducer<TestWidget>()
        
        let widget = TestWidget()
        
        guard let initialState = reducer.reduce(action: CacheAction.add([widget]), state: cache) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(initialState.items().count, 1)
        
        guard let nextState = reducer.reduce(action: CacheAction<TestWidget>.clear, state: initialState) as? Cache<TestWidget> else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(nextState.items().count, 0)
    }
    
    func testCanError() {
        let cache = Cache<TestWidget>()
        let reducer = CacheReducer<TestWidget>()
        let error = TestError.error
        
        let initialState = reducer.reduce(action: CacheAction<TestWidget>.error(error), state: cache)
        
        XCTAssertTrue(initialState is Cache<TestWidget>)
    }
    
    func testMustUseCacheAction() {
        let reducer = CacheReducer<TestWidget>()
        let newState = reducer.reduce(action: TestAction.decrease(amount: 1), state: nil)
        
        XCTAssertNil(newState)
    }
    
    func testMustUseCacheState() {
        let widget = TestWidget()
        let reducer = CacheReducer<TestWidget>()
        let newState = reducer.reduce(action: CacheAction.add([widget]), state: TestState())
        
        XCTAssertTrue(newState is TestState)
    }
    
}
