/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import XCTest

@testable import AoC

class TestDay02: XCTestCase {
  let data = [
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
    "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
    "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
    "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
    "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
  ]

  func testIsGamePossible() throws {
    XCTAssertTrue(
      Day02.isGamePossible(
        game: Day02.Game(id: 1, cubes: ["red": 4, "green": 2, "blue": 6]),
        bag: ["red": 12, "green": 13, "blue": 14]
      )
    )
    XCTAssertTrue(
      Day02.isGamePossible(
        game: Day02.Game(id: 2, cubes: ["red": 1, "green": 3, "blue": 4]),
        bag: ["red": 12, "green": 13, "blue": 14]
      )
    )
    XCTAssertFalse(
      Day02.isGamePossible(
        game: Day02.Game(id: 3, cubes: ["red": 20, "green": 13, "blue": 6]),
        bag: ["red": 12, "green": 13, "blue": 14]
      )
    )
    XCTAssertFalse(
      Day02.isGamePossible(
        game: Day02.Game(id: 4, cubes: ["red": 14, "green": 3, "blue": 15]),
        bag: ["red": 12, "green": 13, "blue": 14]
      )
    )
    XCTAssertTrue(
      Day02.isGamePossible(
        game: Day02.Game(id: 5, cubes: ["red": 6, "green": 3, "blue": 2]),
        bag: ["red": 12, "green": 13, "blue": 14]
      )
    )
  }

  func testParseLine() throws {
    XCTAssertEqual(
      Day02.parseLine("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"),
      Day02.Game(id: 1, cubes: ["red": 4, "green": 2, "blue": 6])
    )
    XCTAssertEqual(
      Day02.parseLine("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"),
      Day02.Game(id: 2, cubes: ["red": 1, "green": 3, "blue": 4])
    )
    XCTAssertEqual(
      Day02.parseLine("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"),
      Day02.Game(id: 3, cubes: ["red": 20, "green": 13, "blue": 6])
    )
    XCTAssertEqual(
      Day02.parseLine("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"),
      Day02.Game(id: 4, cubes: ["red": 14, "green": 3, "blue": 15])
    )
    XCTAssertEqual(
      Day02.parseLine("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"),
      Day02.Game(id: 5, cubes: ["red": 6, "green": 3, "blue": 2])
    )
  }

  func testPossibleGames() throws {
    let games = data.map { Day02.parseLine($0)! }
    let possibleGames = Day02.possibleGames(
      allGames: games, bag: ["red": 12, "green": 13, "blue": 14]
    )

    XCTAssertEqual(possibleGames.map { $0.id }, [1, 2, 5])
  }

  func testPower() throws {
    XCTAssertEqual(Day02.power(Day02.Game(id: 1, cubes: ["red": 4, "green": 2, "blue": 6])), 48)
    XCTAssertEqual(Day02.power(Day02.Game(id: 2, cubes: ["red": 1, "green": 3, "blue": 4])), 12)
    XCTAssertEqual(
      Day02.power(Day02.Game(id: 3, cubes: ["red": 20, "green": 13, "blue": 6])), 1560)
    XCTAssertEqual(Day02.power(Day02.Game(id: 4, cubes: ["red": 14, "green": 3, "blue": 15])), 630)
    XCTAssertEqual(Day02.power(Day02.Game(id: 5, cubes: ["red": 6, "green": 3, "blue": 2])), 36)

    let games = data.map { Day02.parseLine($0)! }
    XCTAssertEqual(games.map({ Day02.power($0) }).sum(), 2286)
  }
}
