/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import CoreLibraries
import XCTest

@testable import AoC

class TestDay09: XCTestCase {
  let data = [
    "0 3 6 9 12 15",
    "1 3 6 10 15 21",
    "10 13 16 21 30 45",
  ]

  func testPart1() throws {
    XCTAssertEqual(data.map({ Day09.parseHistory($0).extendFuture().lastValue }).sum(), 114)
  }

  func testPart2() throws {
    XCTAssertEqual(data.map({ Day09.parseHistory($0).extendPast().firstValue }).sum(), 2)
  }

  func testHistory_ExtendFuture() throws {
    let h = Day09.parseHistory("0 3 6 9 12 15")
    h.extendFuture()
    XCTAssertEqual(h.sequences.count, 3)
    XCTAssertEqual(h.sequences[0], [0, 3, 6, 9, 12, 15, 18])
    XCTAssertEqual(h.sequences[1], [3, 3, 3, 3, 3, 3])
    XCTAssertEqual(h.sequences[2], [0, 0, 0, 0, 0])
  }

  func testHistory_ExtendPast() throws {
    let h = Day09.parseHistory("0 3 6 9 12 15")
    h.extendPast()
    XCTAssertEqual(h.sequences.count, 3)
    XCTAssertEqual(h.sequences[0], [-3, 0, 3, 6, 9, 12, 15])
    XCTAssertEqual(h.sequences[1], [3, 3, 3, 3, 3, 3])
    XCTAssertEqual(h.sequences[2], [0, 0, 0, 0, 0])
  }

  func testHistory_FirstValue() throws {
    let h = Day09.parseHistory("0 3 6 9 12 15")
    XCTAssertEqual(h.firstValue, 0)
    h.extendPast()
    XCTAssertEqual(h.firstValue, -3)
  }

  func testHistory_LastValue() throws {
    let h = Day09.parseHistory("0 3 6 9 12 15")
    XCTAssertEqual(h.lastValue, 15)
    h.extendFuture()
    XCTAssertEqual(h.lastValue, 18)
  }

  func testParseHistory() throws {
    let h = Day09.parseHistory("0 3 6 9 12 15")
    XCTAssertEqual(h.sequences.count, 3)
    XCTAssertEqual(h.sequences[0], [0, 3, 6, 9, 12, 15])
    XCTAssertEqual(h.sequences[1], [3, 3, 3, 3, 3])
    XCTAssertEqual(h.sequences[2], [0, 0, 0, 0])
  }

  func testParseLine() throws {
    XCTAssertEqual(Day09.parseLine("0 3 6 9 12 15"), [0, 3, 6, 9, 12, 15])
  }
}
