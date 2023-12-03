/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Common
import Extensions
import Foundation

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

    print("day 02 part 2: \(data.count)")
  }

  static func isGamePossible(game: Game, bag: [String: Int]) -> Bool {
    return bag.allSatisfy({ (color, count) in return count >= game.cubes[color, default: 0] })
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
    return allGames.filter { isGamePossible(game: $0, bag: bag) }
  }
}
