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

class TestDay03: XCTestCase {
  func testParseLine() throws {
    let claim = Day03.parseLine("#1 @ 520,746: 4x20")!
    XCTAssertEqual(claim.number, 1)
    XCTAssertEqual(claim.squares.count, 80)
    XCTAssert(claim.squares.contains(Point2D(x: 520, y: 746)))
    XCTAssert(claim.squares.contains(Point2D(x: 523, y: 746)))
    XCTAssertFalse(claim.squares.contains(Point2D(x: 524, y: 746)))
    XCTAssert(claim.squares.contains(Point2D(x: 520, y: 765)))
    XCTAssertFalse(claim.squares.contains(Point2D(x: 520, y: 766)))
  }
}
