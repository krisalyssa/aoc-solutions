/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import XCTest

@testable import AoC

class TestDay01: XCTestCase {
  let part1Lines = [
    "1abc2",
    "pqr3stu8vwx",
    "a1b2c3d4e5f",
    "treb7uchet",
  ]

  let part2Lines = [
    "two1nine",
    "eightwothree",
    "abcone2threexyz",
    "xtwone3four",
    "4nineeightseven2",
    "zoneight234",
    "7pqrstsixteen",
  ]

  func testCalibrationSum() throws {
    XCTAssertEqual(
      Day01.calibrationSum(
        over: part1Lines,
        matchingFirst: Day01.regexJustDigits,
        andLast: Day01.regexJustDigits), 142)
    XCTAssertEqual(
      Day01.calibrationSum(
        over: part2Lines,
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 281)
  }

  func testCalibrationValue() throws {
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "1abc2",
        matchingFirst: Day01.regexJustDigits,
        andLast: Day01.regexJustDigits), 12)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "pqr3stu8vwx",
        matchingFirst: Day01.regexJustDigits,
        andLast: Day01.regexJustDigits), 38)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "a1b2c3d4e5f",
        matchingFirst: Day01.regexJustDigits,
        andLast: Day01.regexJustDigits), 15)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "treb7uchet",
        matchingFirst: Day01.regexJustDigits,
        andLast: Day01.regexJustDigits), 77)

    XCTAssertEqual(
      Day01.calibrationValue(
        in: "two1nine",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 29)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "eightwothree",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 83)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "abcone2threexyz",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 13)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "xtwone3four",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 24)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "4nineeightseven2",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 42)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "zoneight234",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 14)
    XCTAssertEqual(
      Day01.calibrationValue(
        in: "7pqrstsixteen",
        matchingFirst: Day01.regexDigitsAndNamesFirst,
        andLast: Day01.regexDigitsAndNamesLast), 76)
  }

  func testFirstDigit() throws {
    XCTAssertEqual(Day01.firstDigit(in: "1abc2", matching: Day01.regexJustDigits), 1)
    XCTAssertEqual(Day01.firstDigit(in: "pqr3stu8vwx", matching: Day01.regexJustDigits), 3)
    XCTAssertEqual(Day01.firstDigit(in: "a1b2c3d4e5f", matching: Day01.regexJustDigits), 1)
    XCTAssertEqual(Day01.firstDigit(in: "treb7uchet", matching: Day01.regexJustDigits), 7)

    XCTAssertEqual(Day01.firstDigit(in: "two1nine", matching: Day01.regexDigitsAndNamesFirst), 2)
    XCTAssertEqual(
      Day01.firstDigit(in: "eightwothree", matching: Day01.regexDigitsAndNamesFirst), 8)
    XCTAssertEqual(
      Day01.firstDigit(in: "abcone2threexyz", matching: Day01.regexDigitsAndNamesFirst), 1)
    XCTAssertEqual(Day01.firstDigit(in: "xtwone3four", matching: Day01.regexDigitsAndNamesFirst), 2)
    XCTAssertEqual(
      Day01.firstDigit(in: "4nineeightseven2", matching: Day01.regexDigitsAndNamesFirst), 4)
    XCTAssertEqual(Day01.firstDigit(in: "zoneight234", matching: Day01.regexDigitsAndNamesFirst), 1)
    XCTAssertEqual(
      Day01.firstDigit(in: "7pqrstsixteen", matching: Day01.regexDigitsAndNamesFirst), 7)
  }

  func testLastDigit() throws {
    XCTAssertEqual(Day01.lastDigit(in: "1abc2", matching: Day01.regexJustDigits), 2)
    XCTAssertEqual(Day01.lastDigit(in: "pqr3stu8vwx", matching: Day01.regexJustDigits), 8)
    XCTAssertEqual(Day01.lastDigit(in: "a1b2c3d4e5f", matching: Day01.regexJustDigits), 5)
    XCTAssertEqual(Day01.lastDigit(in: "treb7uchet", matching: Day01.regexJustDigits), 7)

    XCTAssertEqual(Day01.lastDigit(in: "two1nine", matching: Day01.regexDigitsAndNamesLast), 9)
    XCTAssertEqual(Day01.lastDigit(in: "eightwothree", matching: Day01.regexDigitsAndNamesLast), 3)
    XCTAssertEqual(
      Day01.lastDigit(in: "abcone2threexyz", matching: Day01.regexDigitsAndNamesLast), 3)
    XCTAssertEqual(Day01.lastDigit(in: "xtwone3four", matching: Day01.regexDigitsAndNamesLast), 4)
    XCTAssertEqual(
      Day01.lastDigit(in: "4nineeightseven2", matching: Day01.regexDigitsAndNamesLast), 2)
    XCTAssertEqual(Day01.lastDigit(in: "zoneight234", matching: Day01.regexDigitsAndNamesLast), 4)
    XCTAssertEqual(Day01.lastDigit(in: "7pqrstsixteen", matching: Day01.regexDigitsAndNamesLast), 6)
  }
}
