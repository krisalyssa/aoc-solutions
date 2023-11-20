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

    print("day 01 part 1: \(Day01.sumDeltas(list: data))")
  }

  public func part2(_ input: Input) {
    let data = input.asIntArray()

    print("day 01 part 2: \(Day01.findStart(list: data))")
  }

  static func findStart(list: [Int]) -> Int {
    var seen = Set<Int>([0])
    var value = 0

    for delta in list.cycled() {
      value += delta
      if seen.contains(value) {
        return value
      }
      seen.insert(value)
    }

    return 0
  }

  static func sumDeltas(list: [Int]) -> Int {
    return list.reduce(0, +)
  }
}
