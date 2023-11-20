/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

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

    print("day 01 part 2: \(data)")
  }

  static func sumDeltas(list: [Int]) -> Int {
    return list.reduce(0, +)
  }
}
