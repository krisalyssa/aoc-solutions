/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Algorithms
import AoCCollections
import AoCCommon
import Foundation
import AoCGeometry

struct Claim: Equatable {
  let number: Int
  let squares: [Point2D]
}

public class Day03: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let squares = CountingSet<Point2D>(data.flatMap { Day03.parseLine($0)!.squares })

    print("day 03 part 1: \(squares.filter { (k, v) in v > 1 }.count)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let claims = data.map { Day03.parseLine($0)! }
    let counts = CountingSet<Point2D>(claims.flatMap { $0.squares })
    let nonoverlapping = claims.first { c in
      Set(c.squares).allSatisfy { counts[$0] == 1 }
    }!

    print("day 03 part 2: \(nonoverlapping.number)")
  }

  static let regex = #/#(\d+)\s+@\s+(\d+),(\d+):\s+(\d+)x(\d+)/#

  static func parseLine(_ line: String) -> Claim? {
    // example: #1 @ 520,746: 4x20
    if let match = line.firstMatch(of: regex) {
      let number = Int(match.1)!
      let left = Int(match.2)!
      let top = Int(match.3)!
      let width = Int(match.4)!
      let height = Int(match.5)!

      var squares = [Point2D]()
      for x in left..<left + width {
        for y in top..<top + height {
          squares.append(Point2D(x: x, y: y))
        }
      }

      return Claim(number: number, squares: squares)
    } else {
      print("regex didn't like this line of input:\n\(line)")
      return nil
    }
  }
}
