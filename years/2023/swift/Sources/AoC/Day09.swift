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
    public func extendFuture() -> Self {
      self.sequences[self.sequences.count - 1].append(0)
      (0..<self.sequences.count - 1).reversed().forEach { i in
        let next = self.sequences[i].last! + self.sequences[i + 1].last!
        self.sequences[i].append(next)
      }
      return self
    }

    @discardableResult
    public func extendPast() -> Self {
      self.sequences[self.sequences.count - 1].insert(0, at: 0)
      (0..<self.sequences.count - 1).reversed().forEach { i in
        let next = self.sequences[i].first! - self.sequences[i + 1].first!
        self.sequences[i].insert(next, at: 0)
      }
      return self
    }

    var firstValue: Int {
      self.sequences.first!.first!
    }

    var lastValue: Int {
      self.sequences.first!.last!
    }
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let sum = data.map({ Day09.parseHistory($0).extendFuture().lastValue }).sum()

    print("day 09 part 1: \(sum)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let sum = data.map({ Day09.parseHistory($0).extendPast().firstValue }).sum()

    print("day 09 part 2: \(sum)")
  }

  static func parseHistory(_ line: String) -> History {
    let s = parseLine(line)
    return History(s)
  }

  static func parseLine(_ line: String) -> [Int] {
    line.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: #/\s+/#).map { Int($0)! }
  }
}
