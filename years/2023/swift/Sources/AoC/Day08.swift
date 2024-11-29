/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
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

  public struct Walker {
    let id: Int
    let map: Map
    var currentNode: String

    public func step(_ instruction: String) -> String? {
      switch instruction {
      case "L":
        return map.nodes[currentNode]!.left

      case "R":
        return map.nodes[currentNode]!.right

      default:
        print("unexpected instruction \(instruction)")
        return nil
      }
    }
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let map = Day08.parseMap(data)
    let steps = Day08.walk(map)

    print("day 08 part 1: \(steps)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let map = Day08.parseMap(data)
    let steps = Day08.walkAll(map)

    print("day 08 part 2: \(steps)")
  }

  static func gcd(_ a: Int, _ b: Int) -> Int {
    if a < b {
      return gcd(b, a)
    }

    if b == 0 {
      return a
    }

    return gcd(b, a % b)
  }

  static func gcd(_ s: [Int]) -> Int {
    switch s.count {
    case 2:
      return gcd(s.first!, s.last!)
    case 1:
      return s.first!
    default:
      return gcd(s.first!, gcd(Array(s[1..<s.endIndex])))
    }
  }

  static func lcm(_ a: Int, _ b: Int) -> Int {
    a / gcd(a, b) * b
  }

  static func lcm(_ s: [Int]) -> Int {
    switch s.count {
    case 2:
      return lcm(s.first!, s.last!)
    case 1:
      return s.first!
    default:
      return lcm(s.first!, lcm(Array(s[1..<s.endIndex])))
    }
  }

  static func parseMap(_ data: [String]) -> Map {
    let instructions = data[0]
    var nodes: [String: Node] = [:]

    for i in 1..<data.count {
      let line = data[i]
      if let match = line.firstMatch(of: #/([A-Z0-9]+)\s+=\s+\(([A-Z0-9]+),\s+([A-Z0-9]+)\)/#) {
        let name = String(match.1)
        let left = String(match.2)
        let right = String(match.3)

        nodes[name] = Node(left: left, right: right)
      }
    }

    return Map(instructions: instructions, nodes: nodes)
  }

  static func isStartNode(_ name: String) -> Bool { name.hasSuffix("A") }
  static func isEndNode(_ name: String) -> Bool { name.hasSuffix("Z") }

  static func startNodes(_ map: Map) -> [String] {
    Array(map.nodes.keys.filter(isStartNode))
  }

  static func walk(_ map: Map) -> Int {
    var steps = 0
    var walker = Walker(id: 1, map: map, currentNode: "AAA")

    for instruction in map.instructions.cycled() {
      steps += 1
      let nextNode = walker.step(String(instruction))!
      if nextNode == "ZZZ" {
        break
      }
      walker.currentNode = nextNode
    }

    return steps
  }

  static func walkAll(_ map: Map) -> Int {
    var walkers: [Day08.Walker] = Day08.startNodes(map).indexed().map({
      Walker(id: $0, map: map, currentNode: $1)
    })

    var cycleLengths: [Int: Int] = [:]

    for i in 0..<walkers.count {
      var steps = 0

      for instruction in map.instructions.cycled() {
        steps += 1
        let nextNode = walkers[i].step(String(instruction))!
        if isEndNode(nextNode) {
          break
        }
        walkers[i].currentNode = nextNode
      }

      cycleLengths[walkers[i].id] = steps
    }

    return lcm(Array(cycleLengths.values))
  }
}
