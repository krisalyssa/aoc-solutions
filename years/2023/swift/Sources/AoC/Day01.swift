/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCommon
import AoCExtensions
import CoreLibraries

public class Day01: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    print(
      "day 01 part 1: \(Day01.calibrationSum(over: data, matchingFirst: Day01.regexJustDigits, andLast: Day01.regexJustDigits))"
    )
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print(
      "day 01 part 2: \(Day01.calibrationSum(over: data, matchingFirst: Day01.regexDigitsAndNamesFirst, andLast: Day01.regexDigitsAndNamesLast))"
    )
  }

  static func calibrationSum(
    over lines: [String],
    matchingFirst regexFirst: Regex<(Substring, Substring)>,
    andLast regexLast: Regex<(Substring, Substring)>
  ) -> Int {
    lines.map { calibrationValue(in: $0, matchingFirst: regexFirst, andLast: regexLast) }.sum()
  }

  static func calibrationValue(
    in line: String,
    matchingFirst regexFirst: Regex<(Substring, Substring)>,
    andLast regexLast: Regex<(Substring, Substring)>
  ) -> Int {
    let first = firstDigit(in: line, matching: regexFirst)
    let last = lastDigit(in: line, matching: regexLast)
    return (first * 10) + last
  }

  static let regexJustDigits = #/(\d)/#
  static let regexDigitsAndNamesFirst = #/(\d|one|two|three|four|five|six|seven|eight|nine)/#
  static let regexDigitsAndNamesLast = #/(\d|enin|thgie|neves|xis|evif|ruof|eerht|owt|eno)/#

  static func firstDigit(in line: String, matching regex: Regex<(Substring, Substring)>) -> Int {
    let digit =
      switch line.firstMatch(of: regex)!.1 {
      case "one": 1
      case "two": 2
      case "three": 3
      case "four": 4
      case "five": 5
      case "six": 6
      case "seven": 7
      case "eight": 8
      case "nine": 9
      case let n: Int(n)!
      }
    return digit
  }

  // Sometimes you just have to walk away from the code for a little while to gain a fresh perspective.
  // I realized that finding the last digit is the same as reversing the string and finding the first,
  // spelled backwards.
  static func lastDigit(in line: String, matching regex: Regex<(Substring, Substring)>) -> Int {
    let digit =
      switch String(line.reversed()).firstMatch(of: regex)!.1 {
      case "eno": 1
      case "owt": 2
      case "eerht": 3
      case "ruof": 4
      case "evif": 5
      case "xis": 6
      case "neves": 7
      case "thgie": 8
      case "enin": 9
      case let n: Int(n)!
      }
    return digit
  }
}
