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
  func testFindMatchingEntriesBy2() async throws {
    let data = [1721, 979, 366, 299, 675, 1456]
    XCTAssertEqual(Day01.findMatchingEntries(list: data, by: 2), 514579)
  }
}
