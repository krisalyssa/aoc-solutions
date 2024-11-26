/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Collections
import XCTest

@testable import AoC

class TestDay05: XCTestCase {
  func testIsReactivePair() throws {
    XCTAssertFalse(Day05.isReactivePair(lhs: "A", rhs: "b"))
    XCTAssertFalse(Day05.isReactivePair(lhs: "a", rhs: "a"))
    XCTAssertTrue(Day05.isReactivePair(lhs: "a", rhs: "A"))
    XCTAssertTrue(Day05.isReactivePair(lhs: "A", rhs: "a"))
    XCTAssertFalse(Day05.isReactivePair(lhs: "A", rhs: "A"))
  }

  func testReact() throws {
    XCTAssertEqual(Day05.react(polymer: asCharacterArray("aA")), [])
    XCTAssertEqual(Day05.react(polymer: asCharacterArray("abBA")), [])
    XCTAssertEqual(Day05.react(polymer: asCharacterArray("abAB")), ["a", "b", "A", "B"])
    XCTAssertEqual(
      Day05.react(polymer: asCharacterArray("aabAAB")), ["a", "a", "b", "A", "A", "B"])

    XCTAssertEqual(
      Day05.react(polymer: asCharacterArray("dabAcCaCBAcCcaDA")),
      ["d", "a", "b", "C", "B", "A", "c", "a", "D", "A"])
  }

  func asCharacterArray(_ s: String) -> [Character] {
    return Array(s)
  }
}
