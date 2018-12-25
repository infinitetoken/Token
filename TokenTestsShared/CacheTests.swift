//
//  CacheTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/19/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import XCTest
@testable import Token

class CacheTests: XCTestCase {

    func testCanAdd() {
        var cache = Cache<TestWidget>()
        
        let widget = TestWidget()
        
        XCTAssertEqual(cache.items().count, 0)
        
        cache = cache.add([widget])
        
        XCTAssertEqual(cache.items().count, 1)
    }
    
    func testCanMerge() {
        var cache = Cache<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "1")
        
        XCTAssertEqual(cache.items().count, 0)
        
        cache = cache.add([widget1])
        
        XCTAssertEqual(cache.items().count, 1)
        
        cache = cache.merge([widget2])
        
        XCTAssertEqual(cache.items().count, 1)
        
        let widget3 = TestWidget(uuid: "2")
        
        cache = cache.merge([widget3])
        
        XCTAssertEqual(cache.items().count, 2)
    }
    
    func testCanRemove() {
        var cache = Cache<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        
        XCTAssertEqual(cache.items().count, 0)
        
        cache = cache.add([widget1, widget2])
        
        XCTAssertEqual(cache.items().count, 2)
        
        cache = cache.remove([widget1])
        
        XCTAssertEqual(cache.items().count, 1)
        
        let widget3 = TestWidget(uuid: "2")
        
        cache = cache.add([widget3])
        cache = cache.remove([widget2])
        
        XCTAssertEqual(cache.items().count, 0)
    }
    
    func testCanClear() {
        var cache = Cache<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        
        XCTAssertEqual(cache.items().count, 0)
        
        cache = cache.add([widget1, widget2])
        
        XCTAssertEqual(cache.items().count, 2)
        
        cache = cache.clear()
        
        XCTAssertEqual(cache.items().count, 0)
    }
    
    func testCanFindByUUID() {
        var cache = Cache<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        
        cache = cache.add([widget1, widget2])
        
        guard let item1 = cache.item(for: "1") else {
            XCTFail()
            return
        }
        guard let item2 = cache.item(for: "2") else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(item1.uuid, widget1.uuid)
        XCTAssertEqual(item2.uuid, widget2.uuid)
    }
    
    func testCanFindByIndex() {
        var cache = Cache<TestWidget>()
        
        let widget1 = TestWidget(uuid: "1")
        let widget2 = TestWidget(uuid: "2")
        
        cache = cache.add([widget1, widget2])
        
        guard let item1 = cache.item(atIndex: 0) else {
            XCTFail()
            return
        }
        guard let item2 = cache.item(atIndex: 1) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(item1.uuid, widget1.uuid)
        XCTAssertEqual(item2.uuid, widget2.uuid)
    }
    
}
