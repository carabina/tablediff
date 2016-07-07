//
//  MoveTests.swift
//  DeepDiff
//
//  Created by Ian Terrell on 6/28/16.
//  Copyright © 2016 WillowTree. All rights reserved.
//

import XCTest
import DeepDiff

class MoveTests: XCTestCase {

    func testMoveHead() {
        let x: [Int] = [0, 1, 2, 3]
        let y: [Int] = [1, 2, 3, 0]
        let (diff, updates) = x.deepDiff(y)
        XCTAssertEqual([DiffStep.move(fromIndex: 0, toIndex: 3)], diff)
        XCTAssertEqual([], updates)
    }

    func testMoveTail() {
        let x: [Int] = [1, 2, 3, 0]
        let y: [Int] = [0, 1, 2, 3]
        let (diff, updates) = x.deepDiff(y)
        XCTAssertEqual([DiffStep.move(fromIndex: 3, toIndex: 0)], diff)
        XCTAssertEqual([], updates)
    }

    func testMoveMiddle() {
        let x: [Int] = [1, 2, 0, 3]
        let y: [Int] = [1, 0, 2, 3]
        let (diff, updates) = x.deepDiff(y)
        XCTAssertEqual([DiffStep.move(fromIndex: 1, toIndex: 2)], diff)
        XCTAssertEqual([], updates)
    }

    // These won't pass until we resolve the issue with same index and same value being to difficult to transfer to move
    func testMoveMultiple() {
        let x: [Int] = [1, 2, 3]
        let y: [Int] = [3, 2, 1]
        let (diff, updates) = x.deepDiff(y)
        let expectedDiff: [DiffStep<Int,Int>] = [
            DiffStep.move(fromIndex: 0, toIndex: 2),
            DiffStep.move(fromIndex: 2, toIndex: 0),
            ]
        XCTAssertEqual(expectedDiff, diff)
        XCTAssertEqual([], updates)
    }

    func testRandomMoves() {
        let n = 10
        for _ in 0..<n {
            let x = randomArray()
            let y = x.shuffled()
            let (diff, updates) = x.deepDiff(y)
            for d in diff {
                switch d {
                case .delete(_): fallthrough
                case .insert(_, _):
                    XCTFail("Should only have move instructions")
                default:
                    break
                }
            }
            XCTAssertEqual([], updates)
        }
    }
    
    func testComplexMove() {
        let x: [Int] = [342, 604, 390, 870, 745]
        let y: [Int] = [870, 604, 745, 390, 342]
        let (diff, updates) = x.deepDiff(y)
        let expectedDiff: [DiffStep<Int,Int>] = [
            DiffStep.move(fromIndex: 0, toIndex: 4),
            DiffStep.move(fromIndex: 2, toIndex: 3),
            DiffStep.move(fromIndex: 3, toIndex: 0),
        ]
        XCTAssertEqual(expectedDiff, diff)
        XCTAssertEqual([], updates)
    }
}
