/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import XCTest

@testable import AoC

class TestDay01: XCTestCase {
  func testSumDeltas() async throws {
    XCTAssertEqual(Day01.sumDeltas(list: [1, -2, 3, 1]), 3)
    XCTAssertEqual(Day01.sumDeltas(list: [1, 1, 1]), 3)
    XCTAssertEqual(Day01.sumDeltas(list: [1, 1, -2]), 0)
    XCTAssertEqual(Day01.sumDeltas(list: [-1, -2, -3]), -6)
  }
}
