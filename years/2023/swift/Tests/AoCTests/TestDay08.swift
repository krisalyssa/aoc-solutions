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

  let dataPart2 = [
    "LR",
    "",
    "11A = (11B, XXX)",
    "11B = (XXX, 11Z)",
    "11Z = (11B, XXX)",
    "22A = (22B, XXX)",
    "22B = (22C, 22C)",
    "22C = (22Z, 22Z)",
    "22Z = (22B, 22B)",
    "XXX = (XXX, XXX)",
  ]

  func testGcd() throws {
    XCTAssertEqual(Day08.gcd(10, 8), 2)
    XCTAssertEqual(Day08.gcd(8, 10), 2)
    XCTAssertEqual(Day08.gcd(3, 5), 1)
    XCTAssertEqual(Day08.gcd([3]), 3)
    XCTAssertEqual(Day08.gcd([3, 5]), 1)
    XCTAssertEqual(Day08.gcd([30, 45, 60]), 15)
  }

  func testLcm() throws {
    XCTAssertEqual(Day08.lcm(10, 8), 40)
    XCTAssertEqual(Day08.lcm(8, 10), 40)
    XCTAssertEqual(Day08.lcm(3, 5), 15)
    XCTAssertEqual(Day08.lcm([3]), 3)
    XCTAssertEqual(Day08.lcm([3, 5]), 15)
    XCTAssertEqual(Day08.lcm([30, 45, 60]), 180)
  }

  func testParseMap() throws {
    let mapRL = Day08.parseMap(dataRL)
    XCTAssertEqual(mapRL.instructions, "RL")
    XCTAssertEqual(mapRL.nodes.count, 7)
    XCTAssertNotNil(mapRL.nodes["AAA"])
    XCTAssertNil(mapRL.nodes["FOO"])
  }

  func testStartNodes() throws {
    let map = Day08.parseMap(dataPart2)
    XCTAssertEqual(Set(Day08.startNodes(map)), Set(["11A", "22A"]))
  }

  func testWalk() throws {
    let mapRL = Day08.parseMap(dataRL)
    XCTAssertEqual(Day08.walk(mapRL), 2)

    let mapLLR = Day08.parseMap(dataLLR)
    XCTAssertEqual(Day08.walk(mapLLR), 6)
  }
}
