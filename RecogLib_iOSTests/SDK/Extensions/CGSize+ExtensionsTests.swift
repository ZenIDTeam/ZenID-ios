//
//  CGSize+ExtensionsTests.swift
//  RecogLib_iOSTests
//
//  Created by Vladimir Belohradsky on 14.03.2024.
//  Copyright © 2024 ZenID. All rights reserved.
//

import XCTest
@testable import RecogLib_iOS

final class CGSizeExtensionsTests: XCTestCase {

    func testFlipped_GivenSize_ExpectFlippedValues() throws {
        let givenSize = CGSize(width: 100, height: 50)
        let expectSize = CGSize(width: 50, height: 100)
        
        XCTAssertEqual(givenSize.flipped(), expectSize)
    }
    
    func testSizeThatFitsSize_SizeDifferentOrientation_ExpectCorrectValues() throws {
        let givenSize = CGSize(width: 100, height: 50)
        let expectSize = CGSize(width: 25, height: 50)
        
        XCTAssertEqual(CGSize(width: 50, height: 100).sizeThatFitsSize(givenSize), expectSize)
        XCTAssertEqual(CGSize(width: 500, height: 1000).sizeThatFitsSize(givenSize), expectSize)
        XCTAssertEqual(CGSize(width: 5, height: 10).sizeThatFitsSize(givenSize), expectSize)
    }

    func testSizeThatFitsSize_SizeSameOrientation_ExpectCorrectValues() throws {
        let givenSize = CGSize(width: 50, height: 100)
        let expectSize = CGSize(width: 50, height: 100)
        
        XCTAssertEqual(CGSize(width: 50, height: 100).sizeThatFitsSize(givenSize), expectSize)
        XCTAssertEqual(CGSize(width: 500, height: 1000).sizeThatFitsSize(givenSize), expectSize)
        XCTAssertEqual(CGSize(width: 5, height: 10).sizeThatFitsSize(givenSize), expectSize)
    }

}
