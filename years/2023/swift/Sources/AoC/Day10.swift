/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCollections
import AoCCommon
import AoCExtensions
import AoCGeometry
import CoreLibraries

public class Day10: Day {
  public init() {}

  public enum TileKind {
    case vertical
    case horizontal
    case northEast
    case northWest
    case southWest
    case southEast
    case ground
    case start
  }

  public class Tile: Hashable {
    let location: Point2D
    var kind: TileKind?
    let start: Bool
    var connections: [Point2D]

    public init(x: Int, y: Int, symbol: Character) {
      self.location = Point2D(x: x, y: y)
      let kind = Self.symbolToKind(symbol)
      if kind == .start {
        self.kind = nil
        self.start = true
      } else {
        self.kind = kind
        self.start = false
      }

      switch kind {
      case .vertical: self.connections = [Point2D(x: x, y: y - 1), Point2D(x: x, y: y + 1)]
      case .horizontal: self.connections = [Point2D(x: x - 1, y: y), Point2D(x: x + 1, y: y)]
      case .northEast: self.connections = [Point2D(x: x, y: y - 1), Point2D(x: x + 1, y: y)]
      case .northWest: self.connections = [Point2D(x: x, y: y - 1), Point2D(x: x - 1, y: y)]
      case .southWest: self.connections = [Point2D(x: x, y: y + 1), Point2D(x: x - 1, y: y)]
      case .southEast: self.connections = [Point2D(x: x, y: y + 1), Point2D(x: x + 1, y: y)]
      default: self.connections = []
      }
    }

    static func symbolToKind(_ symbol: Character) -> TileKind {
      switch symbol {
      case "|": return .vertical
      case "-": return .horizontal
      case "L": return .northEast
      case "J": return .northWest
      case "7": return .southWest
      case "F": return .southEast
      case "S": return .start
      default: return .ground
      }
    }

    public static func == (lhs: Day10.Tile, rhs: Day10.Tile) -> Bool {
      lhs.location == rhs.location
    }

    public func hash(into hasher: inout Hasher) { hasher.combine(self.location) }
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let map = Day10.parseMap(data)
    let visited = Day10.findLoop(map: map)

    print("day 10 part 1: \(visited.count / 2)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print("day 10 part 2: \(data.count)")
  }

  static func findLoop(map: [Tile]) -> Set<Point2D> {
    let start = Day10.findStart(map: map)
    var visited: Set<Point2D> = [start.location]
    var deque: Deque<Point2D> = Deque(start.connections)
    while !deque.isEmpty {
      let location = deque.popFirst()!
      if !visited.contains(location) {
        visited.insert(location)
        deque.insert(contentsOf: Day10.findTile(map: map, at: location)!.connections, at: 0)
      }
    }

    return visited
  }

  static func findStart(map: [Tile]) -> Tile {
    map.first(where: { $0.start })!
  }

  static func findTile(map: [Tile], at location: Point2D) -> Tile? {
    map.first(where: { $0.location == location })
  }

  static func parseCharacter(_ char: Character, x: Int, y: Int) -> Tile {
    Tile(x: x, y: y, symbol: char)
  }

  static func parseLine(_ line: String, y: Int) -> [Tile] {
    line.enumerated().map { (i, s) in
      Tile(x: i, y: y, symbol: s)
    }
  }

  static func parseMap(_ map: [String]) -> [Tile] {
    let tiles = map.indexed().reduce(
      [],
      { acc, element in
        acc + parseLine(element.1, y: element.0)
      })
    let start = findStart(map: tiles)

    for tile in tiles {
      if tile.connections.contains(start.location) {
        start.connections.append(tile.location)
      }
    }

    return tiles
  }
}
