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
    var (candidates, symbols) = Day03.parseData(data: data)

    symbols = Set(
      symbols.map {
        let p = Day03.partsForSymbol(candidates: candidates, symbol: $0)
        return Day03.Symbol(s: $0.s, lineno: $0.lineno, line: $0.line, range: $0.range, parts: p)
      })

    let parts = symbols.reduce(
      Set<Day03.Candidate>(),
      { acc, element in
        return acc.union(element.parts)
      })

    XCTAssertEqual(Day03.score(parts), 4361)
  }

  func testPart2() throws {
    var (candidates, symbols) = Day03.parseData(data: data)

    symbols = Set(
      symbols.map {
        let p = Day03.partsForSymbol(candidates: candidates, symbol: $0)
        return Day03.Symbol(s: $0.s, lineno: $0.lineno, line: $0.line, range: $0.range, parts: p)
      })

    let gears = symbols.filter { $0.s == "*" && $0.parts.count == 2 }
    let sum = gears.map({ Day03.gearRatio(gear: $0) }).sum()

    XCTAssertEqual(sum, 467835)
  }
}
