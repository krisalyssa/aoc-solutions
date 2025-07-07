/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Collections
import Geometry
import XCTest

@testable import AoC

class TestDay06: XCTestCase {
  let lines = [
    "1, 1",
    "1, 6",
    "8, 3",
    "3, 4",
    "5, 5",
    "8, 9",
  ]

  func testBounds() throws {
    let points = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: points)!
    XCTAssertEqual(bounds.minX(), 1)
    XCTAssertEqual(bounds.minY(), 1)
    XCTAssertEqual(bounds.maxX(), 8)
    XCTAssertEqual(bounds.maxY(), 9)
  }

  func testCoordinateArea() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!
    let gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)

    XCTAssertEqual(Day06.coordinateArea(Point2D(x: 3, y: 4), in: gridMap), 9)
    XCTAssertEqual(Day06.coordinateArea(Point2D(x: 5, y: 5), in: gridMap), 17)
  }

  func testFindClosestCoordinateToPoint() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    XCTAssertEqual(
      Day06.findClosestCoordinateToPoint(point: Point2D(x: 3, y: 2), coordinates: coordinates),
      Point2D(x: 3, y: 4))
  }

  func testMapClosestCoordinateToPoints() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!
    let gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)

    XCTAssertEqual(gridMap[Point2D(x: 3, y: 2)], Point2D(x: 3, y: 4))

    // test a point that's equidistant to two coordinates
    XCTAssertNil(gridMap[Point2D(x: 1, y: 4)])
  }

  func testParseLine() throws {
    let points = lines.map { Day06.parseLine($0) }
    XCTAssertEqual(points.first, Point2D(x: 1, y: 1))
    XCTAssertEqual(points.last, Point2D(x: 8, y: 9))
  }

  func testPart1() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!

    var gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)
    gridMap = Day06.removeInfinitePoints(from: gridMap, using: bounds.edgePoints())

    let maxArea = coordinates.map { c in Day06.coordinateArea(c, in: gridMap) }.max { $0 < $1 }!

    XCTAssertEqual(maxArea, 17)
  }

  func testRemovePointsForCoordinate() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!
    var gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)

    let point = Point2D(x: 1, y: 1)
    XCTAssertTrue(gridMap[point] != nil)

    gridMap = Day06.removePointsForCoordinate(point, from: gridMap)

    XCTAssertFalse(gridMap[point] != nil)
    XCTAssertFalse(gridMap[Point2D(x: 1, y: 2)] != nil)
  }

  func testRemoveInfinitePoints() throws {
    let coordinates = lines.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!
    var gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)

    XCTAssertTrue(gridMap[Point2D(x: 1, y: 1)] != nil)
    XCTAssertTrue(gridMap[Point2D(x: 8, y: 4)] != nil)

    let edges = bounds.edgePoints()
    gridMap = Day06.removeInfinitePoints(from: gridMap, using: edges)

    XCTAssertFalse(gridMap[Point2D(x: 1, y: 1)] != nil)
    XCTAssertFalse(gridMap[Point2D(x: 8, y: 4)] != nil)

    XCTAssertEqual(gridMap.count, 26)
  }
}
