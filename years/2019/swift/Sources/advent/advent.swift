import AoC
import ArgumentParser
import Common
import Foundation

let days: [Int: Day] = [
  1: Day01()
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
