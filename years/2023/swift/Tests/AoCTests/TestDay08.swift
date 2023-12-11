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

class TestDay08: XCTestCase {
  let dataRL = [
    "RL",
    "",
    "AAA = (BBB, CCC)",
    "BBB = (DDD, EEE)",
    "CCC = (ZZZ, GGG)",
    "DDD = (DDD, DDD)",
    "EEE = (EEE, EEE)",
    "GGG = (GGG, GGG)",
    "ZZZ = (ZZZ, ZZZ)",
  ]

  let dataLLR = [
    "LLR",
    "",
    "AAA = (BBB, BBB)",
    "BBB = (AAA, ZZZ)",
    "ZZZ = (ZZZ, ZZZ)",
  ]

  func testParseMap() throws {
    let mapRL = Day08.parseMap(dataRL)
    XCTAssertEqual(mapRL.instructions, "RL")
    XCTAssertEqual(mapRL.nodes.count, 7)
    XCTAssertNotNil(mapRL.nodes["AAA"])
    XCTAssertNil(mapRL.nodes["FOO"])
  }

  func testWalk() throws {
    let mapRL = Day08.parseMap(dataRL)
    XCTAssertEqual(Day08.walk(mapRL), 2)

    let mapLLR = Day08.parseMap(dataLLR)
    XCTAssertEqual(Day08.walk(mapLLR), 6)
  }
}
