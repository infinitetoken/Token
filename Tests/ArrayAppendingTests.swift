//
//  ArrayAppendingTests.swift
//  Token
//
//  Created by A.C. Wright Design on 4/19/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import XCTest
@testable import Token

class ArrayAppendingTests: XCTestCase {
    
    func testCanAppendSingleElement() {
        let array = [1, 2, 3]
        
        XCTAssertEqual(array.count, 3)
        
        let newArray = array.appending(4)
        
        XCTAssertEqual(newArray.count, 4)
    }
    
    func testCanAppendMultipleElements() {
        let array = [1, 2, 3]
        
        XCTAssertEqual(array.count, 3)
        
        let newArray = array.appending([4, 5])
        
        XCTAssertEqual(newArray.count, 5)
    }
    
    func testCanAppendSingleElementUsingPlus() {
        let array = [1, 2, 3]
        
        XCTAssertEqual(array.count, 3)
        
        let newArray = array + 4
        
        XCTAssertEqual(newArray.count, 4)
    }
    
    func testCanAppendMultipleElementsUsingPlus() {
        let array = [1, 2, 3]
        
        XCTAssertEqual(array.count, 3)
        
        let newArray = array + [4, 5]
        
        XCTAssertEqual(newArray.count, 5)
    }
    
}
