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

public class Day04: Day {
  typealias Guards = [Int: CountingSet<Int>]

  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray().sorted()

    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    data.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    id = Day04.sleepiestGuard(guards: guards)
    let minute = Day04.sleepiestMinuteForGuard(timeslots: guards[id]!)

    print("day 04 part 1: \(id * minute)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray().sorted()

    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    data.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    let v = (0..<60).map { m in
      let g = Day04.sleepiestGuardForMinute(guards: guards, minute: m)
      return (g.0, m, g.1)
    }.max { a, b in a.2 < b.2 }!

    print("day 04 part 2: \(v.0 * v.1)")
  }

  static let regexBegin = #/\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}\] Guard #(\d+)/#
  static let regexSleep = #/\[\d{4}-\d{2}-\d{2} \d{2}:(\d{2})\] falls/#
  static let regexWake = #/\[\d{4}-\d{2}-\d{2} \d{2}:(\d{2})\] wakes/#

  static func minutesSleeping(_ timeslots: CountingSet<Int>) -> Int {
    timeslots.values.reduce(0, +)
  }

  static func parseLine(_ line: String, id: inout Int, sleep: inout Int, guards: inout Guards) {
    if let match = line.firstMatch(of: regexBegin) {
      id = Int(match.1)!
      return
    }

    if let match = line.firstMatch(of: regexSleep) {
      sleep = Int(match.1)!
      return
    }

    if let match = line.firstMatch(of: regexWake) {
      for ts in sleep..<Int(match.1)! {
        guards[id, default: CountingSet<Int>(minimumCapacity: 60)][ts, default: 0] += 1
      }
    }
  }

  static func sleepiestGuard(guards: [Int: CountingSet<Int>]) -> Int {
    let minutesSlept = guards.map { (id, timeslots) in
      return (id, Day04.minutesSleeping(timeslots))
    }

    let (id, _) = minutesSlept.max { a, b in a.1 < b.1 }!
    return id
  }

  static func sleepiestGuardForMinute(guards: [Int: CountingSet<Int>], minute: Int) -> (Int, Int) {
    guards.map { (id, timeslots) in
      (id, timeslots[minute] ?? 0)
    }.max { a, b in
      a.1 < b.1
    }!
  }

  static func sleepiestMinuteForGuard(timeslots: CountingSet<Int>) -> Int {
    let (minute, _) = timeslots.max { a, b in a.1 < b.1 }!
    return minute
  }
}
