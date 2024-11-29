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

public class Day02: Day {
  struct Game: Equatable {
    let id: Int
    var cubes: [String: Int]
  }

  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let games = data.map { Day02.parseLine($0)! }
    let possibleGames = Day02.possibleGames(
      allGames: games, bag: ["red": 12, "green": 13, "blue": 14]
    )

    print("day 02 part 1: \(possibleGames.map({ $0.id }).sum())")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    let games = data.map { Day02.parseLine($0)! }

    print("day 02 part 2: \(games.map({ Day02.power($0) }).sum())")
  }

  static func isGamePossible(game: Game, bag: [String: Int]) -> Bool {
    bag.allSatisfy({ (color, count) in return count >= game.cubes[color, default: 0] })
  }

  // "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",

  static let regexGame = #/^Game\s+(\d+):(.+)$/#
  static let regexCubes = #/(\d+)\s+(red|green|blue)/#

  static func parseLine(_ line: String) -> Game? {
    if let matchGame = line.firstMatch(of: regexGame) {
      var game = Game(id: Int(matchGame.1)!, cubes: [:])
      for reveal in matchGame.2.split(separator: #/\s*;\s*/#) {
        for cubes in reveal.split(separator: #/\s*,\s*/#) {
          if let matchCubes = cubes.firstMatch(of: regexCubes) {
            let color = String(matchCubes.2)
            game.cubes[color] = max(game.cubes[color, default: 0], Int(matchCubes.1)!)
          }
        }
      }

      return game
    }

    return nil
  }

  static func possibleGames(allGames: [Game], bag: [String: Int]) -> [Game] {
    allGames.filter { isGamePossible(game: $0, bag: bag) }
  }

  static func power(_ game: Game) -> Int {
    game.cubes["red"]! * game.cubes["green"]! * game.cubes["blue"]!
  }
}
