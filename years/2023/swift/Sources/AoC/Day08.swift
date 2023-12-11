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
import CoreLibraries

public class Day08: Day {
  public init() {}

  public struct Node {
    let left: String
    let right: String
  }

  public struct Map {
    let instructions: String
    let nodes: [String: Node]
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let mapRL = Day08.parseMap(data)
    let steps = Day08.walk(mapRL)

    print("day 08 part 1: \(steps)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print("day 08 part 2: \(data.count)")
  }

  static func parseMap(_ data: [String]) -> Map {
    let instructions = data[0]
    var nodes: [String: Node] = [:]

    for i in 2..<data.count {
      let line = data[i]
      if let match = line.firstMatch(of: #/([A-Z]+)\s+=\s+\(([A-Z]+),\s+([A-Z]+)\)/#) {
        let name = String(match.1)
        let left = String(match.2)
        let right = String(match.3)

        nodes[name] = Node(left: left, right: right)
      }
    }

    return Map(instructions: instructions, nodes: nodes)
  }

  static func walk(_ map: Map) -> Int {
    var steps = 0
    var current = "AAA"

    for instruction in map.instructions.cycled() {
      steps += 1

      var next: String? = nil
      switch instruction {
      case "L":
        next = map.nodes[current]!.left

      case "R":
        next = map.nodes[current]!.right

      default:
        next = nil
      }

      if next == "ZZZ" {
        return steps
      }

      current = next!
    }

    return steps
  }
}
