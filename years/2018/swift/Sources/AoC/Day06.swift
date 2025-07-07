/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Algorithms
import Collections
import Common
import Foundation
import Geometry

public class Day06: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let coordinates = data.map { Day06.parseLine($0)! }
    let bounds = Day06.bounds(points: coordinates)!

    var gridMap = Day06.mapClosestCoordinateToPoints(
      points: bounds.gridPoints(), coordinates: coordinates)
    gridMap = Day06.removeInfinitePoints(from: gridMap, using: bounds.edgePoints())

    let maxArea = coordinates.map { c in Day06.coordinateArea(c, in: gridMap) }.max { $0 < $1 }!

    print("day 06 part 1: \(maxArea)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let points = data.map { Day06.parseLine($0)! }

    print("day 06 part 2: \(points.count)")
  }

  static func bounds(points: [Point2D]) -> Rect2D? {
    if points.isEmpty { return nil }

    let minX = points.min { p1, p2 in p1.x < p2.x }!.x
    let maxX = points.max { p1, p2 in p1.x < p2.x }!.x
    let minY = points.min { p1, p2 in p1.y < p2.y }!.y
    let maxY = points.max { p1, p2 in p1.y < p2.y }!.y

    return Rect2D(topLeft: Point2D(x: minX, y: minY), bottomRight: Point2D(x: maxX, y: maxY))
  }

  static func coordinateArea(_ coordinate: Point2D, in gridMap: [Point2D: (Point2D, Int)?]) -> Int {
    gridMap.filter { (k, v) in v!.0 == coordinate }.count
  }

  static func findClosestCoordinateToPoint(point: Point2D, coordinates: [Point2D]) -> (
    Point2D, Int
  )? {
    let byDistance = coordinates.map { ($0, point.manhattanDistance($0)) }.sorted { $0.1 < $1.1 }
    let minDistance = byDistance.first!.1

    if byDistance.filter({ $0.1 == minDistance }).count > 1 {
      return nil
    }

    return byDistance[0]
  }

  static func mapClosestCoordinateToPoints(points: [Point2D], coordinates: [Point2D]) -> [Point2D:
    (Point2D, Int)?]
  {
    var pointMap: [Point2D: (Point2D, Int)?] = [:]
    for point in points {
      pointMap[point] = findClosestCoordinateToPoint(point: point, coordinates: coordinates)
    }
    return pointMap
  }

  static let regex = #/(\d+)\s*,\s*(\d+)/#

  static func parseLine(_ line: String) -> Point2D? {
    if let match = line.firstMatch(of: regex) {
      let x = Int(match.1)!
      let y = Int(match.2)!
      return Point2D(x: x, y: y)
    }

    return nil
  }

  static func removePointsForCoordinate(
    _ coordinate: Point2D, from gridMap: [Point2D: (Point2D, Int)?]
  )
    -> [Point2D: (Point2D, Int)?]
  {
    gridMap.filter { (k, v) in v!.0 != coordinate }
  }

  static func removeInfinitePoints(from grid: [Point2D: (Point2D, Int)?], using edges: [Point2D])
    -> [Point2D: (Point2D, Int)?]
  {
    var cleaned = grid

    for point in edges {
      if cleaned[point] != nil {
        cleaned = removePointsForCoordinate(point, from: cleaned)
      }
    }

    return cleaned
  }
}
