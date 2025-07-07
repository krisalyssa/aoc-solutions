/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCGeometry
import CoreLibraries
import XCTest

@testable import AoC

class TestDay10: XCTestCase {
  let dataSimple = [
    "-L|F7",
    "7S-7|",
    "L|7||",
    "-L-J|",
    "L|-JF",
  ]
  let dataComplex = [
    "7-F7-",
    ".FJ|7",
    "SJLL7",
    "|F--J",
    "LJ.LJ",
  ]

  func testPart1() throws {
  }

  func testPart2() throws {
  }

  func testFindLoop() throws {
    XCTAssertEqual(Day10.findLoop(map: Day10.parseMap(dataSimple)).count, 8)
    XCTAssertEqual(Day10.findLoop(map: Day10.parseMap(dataComplex)).count, 16)
  }

  func testFindStart() throws {
    XCTAssertEqual(Day10.findStart(map: Day10.parseMap(dataSimple)).location, Point2D(x: 1, y: 1))
    XCTAssertEqual(Day10.findStart(map: Day10.parseMap(dataComplex)).location, Point2D(x: 0, y: 2))
  }

  func testParseCharacter() throws {
    var t = Day10.parseCharacter("|", x: 3, y: 1)
    XCTAssertEqual(t.location, Point2D(x: 3, y: 1))
    XCTAssertEqual(t.kind, .vertical)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.allSatisfy({ $0.x == 3 }))
    XCTAssertTrue(t.connections.allSatisfy({ $0.y != 1 }))

    t = Day10.parseCharacter("-", x: 1, y: 0)
    XCTAssertEqual(t.location, Point2D(x: 1, y: 0))
    XCTAssertEqual(t.kind, .horizontal)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.allSatisfy({ $0.x != 1 }))
    XCTAssertTrue(t.connections.allSatisfy({ $0.y == 0 }))

    t = Day10.parseCharacter("L", x: 2, y: 2)
    XCTAssertEqual(t.location, Point2D(x: 2, y: 2))
    XCTAssertEqual(t.kind, .northEast)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.contains(where: { $0.x == 2 && $0.y == 1 }))
    XCTAssertTrue(t.connections.contains(where: { $0.x == 3 && $0.y == 2 }))

    t = Day10.parseCharacter("J", x: 1, y: 4)
    XCTAssertEqual(t.location, Point2D(x: 1, y: 4))
    XCTAssertEqual(t.kind, .northWest)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.contains(where: { $0.x == 1 && $0.y == 3 }))
    XCTAssertTrue(t.connections.contains(where: { $0.x == 0 && $0.y == 4 }))

    t = Day10.parseCharacter("7", x: 0, y: 0)
    XCTAssertEqual(t.location, Point2D(x: 0, y: 0))
    XCTAssertEqual(t.kind, .southWest)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.contains(where: { $0.x == -1 && $0.y == 0 }))
    XCTAssertTrue(t.connections.contains(where: { $0.x == 0 && $0.y == 1 }))

    t = Day10.parseCharacter("F", x: 1, y: 3)
    XCTAssertEqual(t.location, Point2D(x: 1, y: 3))
    XCTAssertEqual(t.kind, .southEast)
    XCTAssertFalse(t.start)
    XCTAssertTrue(t.connections.contains(where: { $0.x == 2 && $0.y == 3 }))
    XCTAssertTrue(t.connections.contains(where: { $0.x == 1 && $0.y == 4 }))

    t = Day10.parseCharacter(".", x: 0, y: 1)
    XCTAssertEqual(t.location, Point2D(x: 0, y: 1))
    XCTAssertEqual(t.kind, .ground)
    XCTAssertFalse(t.start)
    XCTAssertEqual(t.connections.count, 0)

    t = Day10.parseCharacter("S", x: 0, y: 2)
    XCTAssertEqual(t.location, Point2D(x: 0, y: 2))
    XCTAssertTrue(t.start)
    XCTAssertEqual(t.connections.count, 0)
  }

  func testParseLine() throws {
    let line = Day10.parseLine("-L|F7", y: 0)
    XCTAssertEqual(line.count, 5)
    XCTAssertEqual(line[0].kind, .horizontal)
    XCTAssertEqual(line[3].location.x, 3)
  }

  func testParseMap() throws {
    let map = Day10.parseMap(dataSimple)
    XCTAssertEqual(map.count, 25)
    XCTAssertEqual(map[0].kind, .horizontal)
    XCTAssertEqual(map[11].location.x, 1)
    XCTAssertEqual(map[11].location.y, 2)
  }
}
