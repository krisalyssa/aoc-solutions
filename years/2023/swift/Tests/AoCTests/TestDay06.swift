/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import CoreLibraries
import XCTest

@testable import AoC

class TestDay06: XCTestCase {
  let data = [
    "Time:      7  15   30",
    "Distance:  9  40  200",
  ]

  func testPart1() throws {
    let score = Day06.parseInput(data)
      .map({ (t, d) in Day06.winningStrategies(time: t, distance: d).count }).reduce(1, *)
    XCTAssertEqual(score, 288)
  }

  func testParseInput() throws {
    XCTAssertEqual(Day06.parseInput(data), [7: 9, 15: 40, 30: 200])
  }

  func testRunRace() throws {
    XCTAssertEqual(Day06.runRace(7), [0, 6, 10, 12, 12, 10, 6, 0])
    XCTAssertEqual(
      Day06.runRace(15), [0, 14, 26, 36, 44, 50, 54, 56, 56, 54, 50, 44, 36, 26, 14, 0])
    XCTAssertEqual(
      Day06.runRace(30),
      [
        0, 29, 56, 81, 104, 125, 144, 161, 176, 189, 200, 209, 216, 221, 224, 225, 224, 221, 216,
        209, 200, 189, 176, 161, 144, 125, 104, 81, 56, 29, 0,
      ])
  }

  func testWinningStrategies() throws {
    XCTAssertEqual(Day06.winningStrategies(time: 7, distance: 9), [2, 3, 4, 5])
    XCTAssertEqual(Day06.winningStrategies(time: 15, distance: 40), [4, 5, 6, 7, 8, 9, 10, 11])
    XCTAssertEqual(
      Day06.winningStrategies(time: 30, distance: 200), [11, 12, 13, 14, 15, 16, 17, 18, 19])
  }
}
