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
import Collections
import AoCCommon
import Foundation

public class Day05: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asCharacterArray().filter { $0 != "\n" }

    print("day 05 part 1: \(String(Day05.react(polymer: data)).count)")
  }

  public func part2(_ input: Input) {
    let data = input.asCharacterArray().filter { $0 != "\n" }

    let shortest = Array("abcdefghijklmnopqrstuvwxyz").map { c in
      Day05.react(polymer: data, skipping: Character(String(c))).count
    }.min { a, b in a < b }!

    print("day 05 part 2: \(shortest)")
  }

  static func isReactivePair(lhs: Character?, rhs: Character?) -> Bool {
    if lhs == nil || rhs == nil { return false }

    return (lhs!.lowercased() == rhs!.lowercased())
      && ((lhs!.isLowercase && rhs!.isUppercase)
        || (lhs!.isUppercase && rhs!.isLowercase))
  }

  static func react(polymer: [Character], skipping: Character? = nil) -> [Character] {
    var reacted: [Character] = []

    for i in 0..<polymer.count {
      if (skipping == nil) || (skipping!.lowercased() != polymer[i].lowercased()) {
        if isReactivePair(lhs: polymer[i], rhs: reacted.last) {
          let _ = reacted.popLast()
        } else {
          reacted.append(polymer[i])
        }
      }
    }

    return reacted
  }
}
