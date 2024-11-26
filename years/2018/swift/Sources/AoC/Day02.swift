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
import AoCCommon
import Foundation

struct Candidate: Equatable {
  let is2: Bool
  let is3: Bool
}

public class Day02: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    print("day 02 part 1: \(Day02.checksum(data))")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print("day 02 part 2: \(Day02.boxesWithPrototypeFabric(boxIDs: data))")
  }

  static func boxesWithPrototypeFabric(boxIDs: [String]) -> String {
    for pair in boxIDs.combinations(ofCount: 2) {
      if hamming(lhs: pair[0], rhs: pair[1]) == 1 {
        return zip(pair[0], pair[1]).filter { $0 == $1 }.map { String($0.0) }.joined()
      }
    }

    return ""
  }

  static func characterCounts(_ boxID: String) -> [Character: Int] {
    return Dictionary(zip(boxID, repeatElement(1, count: Int.max)), uniquingKeysWith: +)
  }

  static func checksum(_ boxIDs: [String]) -> Int {
    let candidates = boxIDs.map { id in likelyCandidate(String(id)) }
    let twos = candidates.filter { c in c.is2 }.count
    let threes = candidates.filter { c in c.is3 }.count
    return twos * threes
  }

  static func hamming(lhs: String, rhs: String) -> Int {
    return zip(lhs, rhs).filter { $0 != $1 }.count
  }

  static func likelyCandidate(_ boxID: String) -> Candidate {
    let counts = characterCounts(boxID)
    return Candidate(
      is2: counts.contains { pair in pair.value == 2 },
      is3: counts.contains { pair in pair.value == 3 }
    )
  }
}
