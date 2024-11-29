/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Collections
import XCTest

@testable import AoC

class TestDay04: XCTestCase {
  let lines = [
    "[1518-11-01 00:00] Guard #10 begins shift",
    "[1518-11-01 00:05] falls asleep",
    "[1518-11-01 00:25] wakes up",
    "[1518-11-01 00:30] falls asleep",
    "[1518-11-01 00:55] wakes up",
    "[1518-11-01 23:58] Guard #99 begins shift",
    "[1518-11-02 00:40] falls asleep",
    "[1518-11-02 00:50] wakes up",
    "[1518-11-03 00:05] Guard #10 begins shift",
    "[1518-11-03 00:24] falls asleep",
    "[1518-11-03 00:29] wakes up",
    "[1518-11-04 00:02] Guard #99 begins shift",
    "[1518-11-04 00:36] falls asleep",
    "[1518-11-04 00:46] wakes up",
    "[1518-11-05 00:03] Guard #99 begins shift",
    "[1518-11-05 00:45] falls asleep",
    "[1518-11-05 00:55] wakes up",
  ]

  func testMinutesSleeping() throws {
    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    lines.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    XCTAssertEqual(Day04.minutesSleeping(guards[10]!), 50)
    XCTAssertEqual(Day04.minutesSleeping(guards[99]!), 30)
  }

  func testParseLine() throws {
    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    Day04.parseLine(
      "[1518-11-01 00:00] Guard #10 begins shift", id: &id, sleep: &start, guards: &guards)
    XCTAssertEqual(id, 10)
    XCTAssertEqual(start, 0)
    XCTAssertNil(guards[id])

    Day04.parseLine(
      "[1518-11-01 00:05] falls asleep", id: &id, sleep: &start, guards: &guards)
    XCTAssertEqual(id, 10)
    XCTAssertEqual(start, 5)
    XCTAssertNil(guards[id])

    Day04.parseLine(
      "[1518-11-01 00:25] wakes up", id: &id, sleep: &start, guards: &guards)
    XCTAssertEqual(id, 10)
    XCTAssertEqual(start, 5)
    XCTAssertNotNil(guards[id])
    XCTAssertNil(guards[id]![4])
    XCTAssertEqual(guards[id]![5], 1)
    XCTAssertEqual(guards[id]![6], 1)
    XCTAssertEqual(guards[id]![23], 1)
    XCTAssertEqual(guards[id]![24], 1)
    XCTAssertNil(guards[id]![25])

    Day04.parseLine(
      "[1518-11-03 00:05] Guard #10 begins shift", id: &id, sleep: &start, guards: &guards)
    Day04.parseLine(
      "[1518-11-03 00:24] falls asleep", id: &id, sleep: &start, guards: &guards)
    Day04.parseLine(
      "[1518-11-03 00:29] wakes up", id: &id, sleep: &start, guards: &guards)
    XCTAssertEqual(guards[id]![23], 1)
    XCTAssertEqual(guards[id]![24], 2)
    XCTAssertEqual(guards[id]![25], 1)
  }

  func testSleepiestGuard() throws {
    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    lines.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    XCTAssertEqual(Day04.sleepiestGuard(guards: guards), 10)
  }

  func testSleepiestGuardForMinute() throws {
    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    lines.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    let (g, count) = Day04.sleepiestGuardForMinute(guards: guards, minute: 45)
    XCTAssertEqual(g, 99)
    XCTAssertEqual(count, 3)
  }

  func testSleepiestMinuteForGuard() throws {
    var id = 0
    var start = 0
    var guards: [Int: CountingSet<Int>] = [:]

    lines.forEach {
      Day04.parseLine($0, id: &id, sleep: &start, guards: &guards)
    }

    XCTAssertEqual(Day04.sleepiestMinuteForGuard(timeslots: guards[10]!), 24)
  }
}
