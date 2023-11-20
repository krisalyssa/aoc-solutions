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
import Common
import Foundation

public class Day01: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asIntArray()
    let result = Day01.findMatchingEntries(list: data, by: 2)
    print("day 01 part 1: \(result)")
  }

  public func part2(_ input: Input) {
    let data = input.asIntArray()
    let result = Day01.findMatchingEntries(list: data, by: 3)
    print("day 01 part 1: \(result)")
  }

  static func findMatchingEntries(list: [Int], by: Int) -> Int {
    for group in list.combinations(ofCount: by) {
      if group.reduce(0, +) == 2020 {
        return group.reduce(1, *)
      }
    }

    return 0
  }
}
