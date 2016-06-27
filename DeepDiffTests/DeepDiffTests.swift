//
//  DeepDiffTests.swift
//  DeepDiffTests
//
//  Created by Ian Terrell on 6/27/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import XCTest
import DeepDiff

class DeepDiffTests: XCTestCase {

    func testEmptySame() {
        let x: [Int] = []
        let (diff, updates) = x.deepDiff(x)
        XCTAssertEqual([], diff)
        XCTAssertEqual([], updates)
    }

    func testNonEmptySame() {
        let x: [Int] = [1, 2, 3]
        let (diff, updates) = x.deepDiff(x)
        XCTAssertEqual([], diff)
        XCTAssertEqual([], updates)
    }

    func testRandomNonEmptySame() {
        let n = 10
        (0..<n).forEach { _ in
            let x: [Int] = randomArray()
            let (diff, updates) = x.deepDiff(x)
            XCTAssertEqual([], diff)
            XCTAssertEqual([], updates)
        }
    }
}
