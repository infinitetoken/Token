//
//  ArrayCacheableTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/19/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import XCTest
@testable import Token

class ArrayCacheableTests: XCTestCase {
    
    func testItems() {
        let array: [TestWidget] = [TestWidget(uuid: "123")]
        let items = array.items(for: ["123"])
        
        XCTAssertEqual(items.count, 1)
    }
    
    func testRemovingElement() {
        let widget = TestWidget(uuid: "123")
        var array: [TestWidget] = [widget]
        
        XCTAssertEqual(array.count, 1)
        
        array.remove(widget)
        
        XCTAssertEqual(array.count, 0)
    }
    
    func testRemovingElements() {
        let widget1 = TestWidget(uuid: "123")
        let widget2 = TestWidget(uuid: "234")
        var array: [TestWidget] = [widget1, widget2]
        
        XCTAssertEqual(array.count, 2)
        
        array.remove([widget1, widget2])
        
        XCTAssertEqual(array.count, 0)
    }
    
    func testMerging() {
        let widget1 = TestWidget(uuid: "123")
        let widget2 = TestWidget(uuid: "234")
        let widget3 = TestWidget(uuid: "345")
        var array: [TestWidget] = [widget1, widget2]
        
        XCTAssertEqual(array.count, 2)
        
        array = array.merging(widget2)
        
        XCTAssertEqual(array.count, 2)
        
        array = array.merging(widget3)
        
        XCTAssertEqual(array.count, 3)
    }
    
}
