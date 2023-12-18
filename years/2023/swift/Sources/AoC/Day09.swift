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

public class Day09: Day {
  public init() {}

  public class History {
    var sequences: [[Int]]

    init(_ initial: [Int]) {
      self.sequences = [initial]

      var s = self.sequences.last!
      while !s.allSatisfy({ $0 == 0 }) {
        s = s.adjacentPairs().map({ $0.1 - $0.0 })
        self.sequences.append(s)
      }
    }

    @discardableResult
    public func extend() -> Self {
      self.sequences[self.sequences.count - 1].append(0)
      (0..<self.sequences.count - 1).reversed().forEach { i in
        let next = self.sequences[i].last! + self.sequences[i + 1].last!
        self.sequences[i].append(next)
      }
      return self
    }

    var lastValue: Int {
      self.sequences.first!.last!
    }
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let sum = data.map({ Day09.parseHistory($0).extend().lastValue }).sum()

    print("day 09 part 1: \(sum)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print("day 09 part 2: \(data.count)")
  }

  static func parseHistory(_ line: String) -> History {
    let s = parseLine(line)
    return History(s)
  }

  static func parseLine(_ line: String) -> [Int] {
    line.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: #/\s+/#).map { Int($0)! }
  }
}
