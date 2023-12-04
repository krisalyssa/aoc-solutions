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
  let data = [
    "467..114..",
    "...*......",
    "..35..633.",
    "......#...",
    "617*......",
    ".....+.58.",
    "..592.....",
    "......755.",
    "...$.*....",
    ".664.598..",
  ]

  func testPart1() throws {
    let (candidates, symbols) = Day03.parseData(data: data)
    var parts: Set<Day03.Candidate> = []

    for symbol in symbols {
      parts.formUnion(Day03.partsForSymbol(candidates: candidates, symbol: symbol))
    }

    XCTAssertEqual(Day03.score(parts), 4361)
  }
}
