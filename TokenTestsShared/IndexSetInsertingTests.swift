//
//  IndexSetInsertingTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/14/18.
//  Copyright © 2018 A.C. Wright Design. All rights reserved.
//

import XCTest
@testable import Token

class IndexSetInsertingTests: XCTestCase {
    
    func testInsertingInteger() {
        var indexSet = IndexSet(integer: 1)
        
        XCTAssertEqual(indexSet.count, 1)
        XCTAssertTrue(indexSet.contains(1))
        
        indexSet = indexSet.inserting(2)
        
        XCTAssertEqual(indexSet.count, 2)
        XCTAssertTrue(indexSet.contains(2))
    }
    
    func testInsertingArrayOfIntegers() {
        var indexSet = IndexSet(integer: 1)
        
        XCTAssertEqual(indexSet.count, 1)
        XCTAssertTrue(indexSet.contains(1))
        
        indexSet = indexSet.inserting([2, 3])
        
        XCTAssertEqual(indexSet.count, 3)
        XCTAssertTrue(indexSet.contains(2))
        XCTAssertTrue(indexSet.contains(3))
    }
    
}
