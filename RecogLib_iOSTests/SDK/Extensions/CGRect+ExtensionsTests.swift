//
//  CGRect+ExtensionsTests.swift
//  RecogLib_iOSTests
//
//  Created by Vladimir Belohradsky on 14.03.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import XCTest
@testable import RecogLib_iOS

final class CGRectExtensionsTests: XCTestCase {
    
    func testFlipped_GivenValue_ExpectCorrectValue() throws {
        let givenRect = CGRect(x: 15, y: 25, width: 100, height: 50)
        let expectRect = CGRect(x: 25, y: 15, width: 50, height: 100)
        
        XCTAssertEqual(givenRect.flipped(), expectRect)
    }

    func testRectThatFitsRect_RectDifferentOrientation_ExpectCorrectValues() throws {
        let givenRect = CGRect(x:0, y:0, width: 100, height: 50)
        let expectRect = CGRect(x:37.5, y:0, width: 25, height: 50)
        
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 50, height: 100).rectThatFitsRect(givenRect), expectRect)
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 500, height: 1000).rectThatFitsRect(givenRect), expectRect)
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 5, height: 10).rectThatFitsRect(givenRect), expectRect)
    }
    
    func testRectThatFitsRect_RectSameOrientation_ExpectCorrectValues() throws {
        let givenRect = CGRect(x:0, y:0, width: 50, height: 100)
        let expectRect = CGRect(x:0, y:0, width: 50, height: 100)
        
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 50, height: 100).rectThatFitsRect(givenRect), expectRect)
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 500, height: 1000).rectThatFitsRect(givenRect), expectRect)
        XCTAssertEqual(CGRect(x: 0, y: 0, width: 5, height: 10).rectThatFitsRect(givenRect), expectRect)
    }
    
    func testMoved_GivenOffset_ExpectCorrectValue() throws {
        let givenRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        let offset = CGPoint(x: 15, y: 25)
        let expectRect = CGRect(x: 15, y: 25, width: 10, height: 10)
        
        XCTAssertEqual(givenRect.moved(offset), expectRect)
    }
}
