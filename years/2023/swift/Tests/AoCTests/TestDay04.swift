/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCollections
import XCTest

@testable import AoC

class TestDay04: XCTestCase {
  let data = [
    "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
    "Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
    "Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
    "Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
    "Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
    "Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11",
  ]

  func describeCountingSet(_ s: CountingSet<Int>) -> String {
    var buffer: [String] = []
    for i in s.keys.sorted(by: { $0 < $1 }) {
      buffer.append("\(i): \(s[i]!)")
    }
    return "[\(buffer.joined(separator: ", "))]"
  }

  func testPart1() throws {
    XCTAssertEqual(data.map({ Day04.parseLine($0)! }).map({ Day04.value($0) }).sum(), 13)
  }

  func testPart2() throws {
    var cards: [Int: Day04.Card] = [:]
    cards.merge(data.map({ Day04.parseLine($0)! }).map({ ($0.id, $0) })) { (current, _) in current }

    var pile: CountingSet<Int> = [:]
    for id in cards.keys { pile[id] = 1 }

    for id in cards.keys.sorted() {
      Day04.redeem(card: cards[id]!, pile: &pile)
    }

    XCTAssertEqual(pile.values.sum(), 30)
  }

  func testParseLine() throws {
    XCTAssertEqual(
      Day04.parseLine("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"),
      Day04.Card(
        id: 1, winningNumbers: [41, 48, 83, 86, 17],
        numbersWeHave: [83, 86, 6, 31, 17, 9, 48, 53]))
    XCTAssertEqual(
      Day04.parseLine("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19"),
      Day04.Card(
        id: 2, winningNumbers: [13, 32, 20, 16, 61],
        numbersWeHave: [61, 30, 68, 82, 17, 32, 24, 19]))
    XCTAssertEqual(
      Day04.parseLine("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1"),
      Day04.Card(
        id: 3, winningNumbers: [1, 21, 53, 59, 44],
        numbersWeHave: [69, 82, 63, 72, 16, 21, 14, 1]))
    XCTAssertEqual(
      Day04.parseLine("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83"),
      Day04.Card(
        id: 4, winningNumbers: [41, 92, 73, 84, 69],
        numbersWeHave: [59, 84, 76, 51, 58, 5, 54, 83]))
    XCTAssertEqual(
      Day04.parseLine("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36"),
      Day04.Card(
        id: 5, winningNumbers: [87, 83, 26, 28, 32],
        numbersWeHave: [88, 30, 70, 12, 93, 22, 82, 36]))
    XCTAssertEqual(
      Day04.parseLine("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"),
      Day04.Card(
        id: 6, winningNumbers: [31, 18, 13, 56, 72],
        numbersWeHave: [74, 77, 10, 23, 35, 67, 36, 11]))
  }

  func testRedeem() throws {
    var cards: [Int: Day04.Card] = [:]
    cards.merge(data.map({ Day04.parseLine($0)! }).map({ ($0.id, $0) })) { (current, _) in current }

    var pile: CountingSet<Int> = [:]
    for id in cards.keys { pile[id] = 1 }

    Day04.redeem(card: cards[1]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 2, 4: 2, 5: 2, 6: 1])

    Day04.redeem(card: cards[2]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 4, 4: 4, 5: 2, 6: 1])

    Day04.redeem(card: cards[3]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 4, 4: 8, 5: 6, 6: 1])

    Day04.redeem(card: cards[4]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 4, 4: 8, 5: 14, 6: 1])

    Day04.redeem(card: cards[5]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 4, 4: 8, 5: 14, 6: 1])

    Day04.redeem(card: cards[6]!, pile: &pile)
    XCTAssertEqual(pile, [1: 1, 2: 2, 3: 4, 4: 8, 5: 14, 6: 1])
  }

  func testValue() throws {
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")!), 8)
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19")!), 2)
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1")!), 2)
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83")!), 1)
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36")!), 0)
    XCTAssertEqual(
      Day04.value(Day04.parseLine("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")!), 0)
  }

  func testWinningNumbersWeHave() throws {
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")!),
      [48, 83, 17, 86])
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19")!),
      [32, 61])
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1")!),
      [1, 21])
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83")!),
      [84])
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36")!),
      [])
    XCTAssertEqual(
      Day04.winningNumbersWeHave(
        Day04.parseLine("Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11")!),
      [])
  }
}
