import Common
import Foundation

public class Day01: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asIntArray()
    let total = data.map { Day01.calculateFuel(mass: $0) }.reduce(
      0,
      { x, y in
        x + y
      })

    print("day 01 part 1: \(total)")
  }

  public func part2(_ input: Input) {
    let data = input.asIntArray()
    let total = data.map { Day01.calculateAllFuel(mass: $0) }.reduce(
      0,
      { x, y in
        x + y
      })

    print("day 01 part 2: \(total)")
  }

  static func calculateFuel(mass: Int) -> Int {
    return max((mass / 3) - 2, 0)
  }

  static func calculateAllFuel(mass: Int) -> Int {
    let fuelMass = calculateFuel(mass: mass)
    if fuelMass > 0 {
      return fuelMass + calculateAllFuel(mass: fuelMass)
    } else {
      return fuelMass
    }
  }
}
