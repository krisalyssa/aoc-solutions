/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCollections
import AoCCommon
import AoCExtensions
import Foundation

public class Day04: Day {
  public init() {}

  struct Card: Equatable {
    let id: Int
    let winningNumbers: Set<Int>
    let numbersWeHave: Set<Int>
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    print("day 04 part 1: \(data.map({ Day04.parseLine($0)! }).map({ Day04.value($0) }).sum())")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()
    var cards: [Int: Day04.Card] = [:]
    cards.merge(data.map({ Day04.parseLine($0)! }).map({ ($0.id, $0) })) { (current, _) in current }

    var pile: CountingSet<Int> = [:]
    for id in cards.keys { pile[id] = 1 }

    for id in cards.keys.sorted() {
      Day04.redeem(card: cards[id]!, pile: &pile)
    }

    print("day 04 part 2: \(pile.values.sum())")
  }

  // Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  static let regex = #/Card\s+(\d+):\s+([^|]+)\|\s+(.+)$/#

  static func parseLine(_ line: String) -> Card? {
    if let match = line.firstMatch(of: regex) {
      let id = Int(match.1)!
      let winningNumbers = Set(
        match.2.trimmingPrefix(#/\s+/#).split(separator: #/\s+/#).map { Int($0)! })
      let numbersWeHave = Set(
        match.3.trimmingPrefix(#/\s+/#).split(separator: #/\s+/#).map { Int($0)! })

      return Card(id: id, winningNumbers: winningNumbers, numbersWeHave: numbersWeHave)
    } else {
      return nil
    }
  }

  static func redeem(card: Card, pile: inout CountingSet<Int>) {
    let winningNumbers = Day04.winningNumbersWeHave(card)
    if winningNumbers.count > 0 {
      for i in 1...winningNumbers.count {
        pile[card.id + i, default: 1] += (pile[card.id] ?? 0)
      }
    }
  }

  static func value(_ card: Card) -> Int {
    let count = winningNumbersWeHave(card).count
    if count == 0 {
      return 0
    }

    return 1 << (count - 1)
  }

  static func winningNumbersWeHave(_ card: Card) -> Set<Int> {
    return card.winningNumbers.intersection(card.numbersWeHave)
  }
}
