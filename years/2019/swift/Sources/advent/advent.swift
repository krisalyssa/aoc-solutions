import AoC
import ArgumentParser
import Foundation

let days: [Int: DayRunner] = [
  1: Day01()
]

@main
struct Advent: ParsableCommand {
  @Argument(help: "The day to run.")
  var day: Int

  mutating func run() throws {
    let runner: DayRunner = days[day]!
    let startTime = Date()
    runner.run()
    let endTime = Date()
    print("Time: \(endTime.timeIntervalSince(startTime))")
  }
}
