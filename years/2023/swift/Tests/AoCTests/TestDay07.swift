/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import CoreLibraries
import XCTest

@testable import AoC

class TestDay07: XCTestCase {
  let data = [
    "32T3K 765",
    "T55J5 684",
    "KK677 28",
    "KTJJT 220",
    "QQQJA 483",
  ]

  func testPart1() throws {
    let total = data.map({ Day07.parseLinePart1($0)! }).sorted().enumerated().map({ (rank, hand) in
      hand.winnings(forRank: rank + 1)!
    }).sum()

    XCTAssertEqual(total, 6440)
  }

  func testHand_Comparable() throws {
    XCTAssertTrue(Day07.HandPart1(cards: "AAAAA") > Day07.HandPart1(cards: "AA8AA"))
    XCTAssertTrue(Day07.HandPart1(cards: "AA8AA") > Day07.HandPart1(cards: "23332"))
    XCTAssertTrue(Day07.HandPart1(cards: "23332") > Day07.HandPart1(cards: "TTT98"))
    XCTAssertTrue(Day07.HandPart1(cards: "TTT98") > Day07.HandPart1(cards: "23432"))
    XCTAssertTrue(Day07.HandPart1(cards: "23432") > Day07.HandPart1(cards: "A23A4"))
    XCTAssertTrue(Day07.HandPart1(cards: "A23A4") > Day07.HandPart1(cards: "23456"))

    XCTAssertTrue(Day07.HandPart1(cards: "33332") > Day07.HandPart1(cards: "2AAAA"))
    XCTAssertTrue(Day07.HandPart1(cards: "77888") > Day07.HandPart1(cards: "77788"))

    let hands = [
      Day07.HandPart1(cards: "32T3K"),
      Day07.HandPart1(cards: "T55J5"),
      Day07.HandPart1(cards: "KK677"),
      Day07.HandPart1(cards: "KTJJT"),
      Day07.HandPart1(cards: "QQQJA"),
    ]

    XCTAssertEqual(hands.sorted().map({ $0.cards }), ["32T3K", "KTJJT", "KK677", "T55J5", "QQQJA"])
  }

  func testHand_Equatable() throws {
    XCTAssertTrue(Day07.HandPart1(cards: "AAAAA") == Day07.HandPart1(cards: "AAAAA"))
    XCTAssertFalse(Day07.HandPart1(cards: "AAAAA") == Day07.HandPart1(cards: "AAAAK"))
    XCTAssertFalse(Day07.HandPart1(cards: "AAAAK") == Day07.HandPart1(cards: "AAAKA"))
  }

  func testHand_Type() throws {
    XCTAssertEqual(Day07.HandPart1(cards: "AAAAA").type, .fiveOfAKind)
    XCTAssertEqual(Day07.HandPart1(cards: "AA8AA").type, .fourOfAKind)
    XCTAssertEqual(Day07.HandPart1(cards: "23332").type, .fullHouse)
    XCTAssertEqual(Day07.HandPart1(cards: "TTT98").type, .threeOfAKind)
    XCTAssertEqual(Day07.HandPart1(cards: "23432").type, .twoPair)
    XCTAssertEqual(Day07.HandPart1(cards: "A23A4").type, .onePair)
    XCTAssertEqual(Day07.HandPart1(cards: "23456").type, .highCard)
  }

  func testHand_Values() throws {
    XCTAssertEqual(Day07.HandPart1(cards: "AAAAA").values, [14, 14, 14, 14, 14])
    XCTAssertEqual(Day07.HandPart1(cards: "AA8AA").values, [14, 14, 8, 14, 14])
    XCTAssertEqual(Day07.HandPart1(cards: "23332").values, [2, 3, 3, 3, 2])
    XCTAssertEqual(Day07.HandPart1(cards: "TTT98").values, [10, 10, 10, 9, 8])
    XCTAssertEqual(Day07.HandPart1(cards: "23432").values, [2, 3, 4, 3, 2])
    XCTAssertEqual(Day07.HandPart1(cards: "A23A4").values, [14, 2, 3, 14, 4])
    XCTAssertEqual(Day07.HandPart1(cards: "23456").values, [2, 3, 4, 5, 6])
  }

  func testHand_Winnings() throws {
    let hand = Day07.parseLinePart1("32T3K 765")!
    XCTAssertEqual(hand.winnings(forRank: 3), 765 * 3)
  }

  func testHandType_Comparable() throws {
    XCTAssertTrue(Day07.HandType.fiveOfAKind > Day07.HandType.fourOfAKind)
    XCTAssertFalse(Day07.HandType.fiveOfAKind < Day07.HandType.fourOfAKind)
  }

  func testParseLine() throws {
    let hand = Day07.parseLinePart1("32T3K 765")!
    XCTAssertEqual(hand.bid, 765)
    XCTAssertEqual(hand.cards, "32T3K")
    XCTAssertEqual(hand.values, [3, 2, 10, 3, 13])
  }
}
