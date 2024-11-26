/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoC
import AoCCommon
import ArgumentParser
import CoreLibraries

let days: [Int: Day] = [
  1: Day01(),
  2: Day02(),
  3: Day03(),
  4: Day04(),
  5: Day05(),
  6: Day06(),
  7: Day07(),
  8: Day08(),
  9: Day09(),
    // 10: Day10(),
    // 11: Day11(),
    // 12: Day12(),
    // 13: Day13(),
    // 14: Day14(),
    // 15: Day15(),
    // 16: Day16(),
    // 17: Day17(),
    // 18: Day18(),
    // 19: Day19(),
    // 20: Day20(),
    // 21: Day21(),
    // 22: Day22(),
    // 23: Day23(),
    // 24: Day24(),
    // 25: Day25(),
]

@main
struct Advent: ParsableCommand {
  @Argument(help: "The day to run.")
  var day: Int

  mutating func run() throws {
    let runner: Day = days[day]!
    // let startTime = Date()
    try runner.run(day: day)
    // let endTime = Date()
    // print("Time: \(endTime.timeIntervalSince(startTime))")
  }
}
