/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import XCTest

@testable import AoC

class TestDay01: XCTestCase {
  func testSumDeltas() throws {
    XCTAssertEqual(Day01.sumDeltas(list: [1, -2, 3, 1]), 3)
    XCTAssertEqual(Day01.sumDeltas(list: [1, 1, 1]), 3)
    XCTAssertEqual(Day01.sumDeltas(list: [1, 1, -2]), 0)
    XCTAssertEqual(Day01.sumDeltas(list: [-1, -2, -3]), -6)
  }

  func testFindStart() throws {
    XCTAssertEqual(Day01.findStart(list: [+1, -2, +3, +1]), 2)
    XCTAssertEqual(Day01.findStart(list: [+1, -1]), 0)
    XCTAssertEqual(Day01.findStart(list: [+3, +3, +4, -2, -4]), 10)
    XCTAssertEqual(Day01.findStart(list: [-6, +3, +8, +5, -6]), 5)
    XCTAssertEqual(Day01.findStart(list: [+7, +7, -2, -7, -4]), 14)
  }
}
