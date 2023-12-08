/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCommon
import AoCExtensions
import CoreLibraries

public class Day06: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let score = Day06.parseInputPart1(data)
      .map({ (t, d) in Day06.winningStrategies(time: t, distance: d).count }).reduce(1, *)

    print("day 06 part 1: \(score)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let score = Day06.parseInputPart2(data)
      .map({ (t, d) in Day06.winningStrategies(time: t, distance: d).count }).reduce(1, *)

    print("day 06 part 2: \(score)")
  }

  static func parseInputPart1(_ data: [String]) -> [Int: Int] {
    let times = data[0].replacing(#/^Time:\s+/#, with: "").split(separator: #/\s+/#).map {
      Int($0)!
    }
    let distances = data[1].replacing(#/^Distance:\s+/#, with: "").split(separator: #/\s+/#).map {
      Int($0)!
    }

    return [Int: Int](zip(times, distances), uniquingKeysWith: { (first, _) in first })
  }

  static func parseInputPart2(_ data: [String]) -> [Int: Int] {
    let time = Int(data[0].replacing(#/^Time:\s+/#, with: "").replacing(#/\s+/#, with: ""))!
    let distance = Int(data[1].replacing(#/^Distance:\s+/#, with: "").replacing(#/\s+/#, with: ""))!

    return [time: distance]
  }

  static func runRace(_ raceLength: Int) -> [Int] {
    (0...raceLength).map({ buttonHeld in
      let speed = buttonHeld
      let duration = raceLength - buttonHeld
      return speed * duration
    })
  }

  static func winningStrategies(time: Int, distance: Int) -> [Int] {
    runRace(time).indexed().filter({ (i, d) in d > distance }).map({ (i, _) in i })
  }
}
