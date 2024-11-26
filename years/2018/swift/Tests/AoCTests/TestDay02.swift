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

class TestDay02: XCTestCase {
  func testBoxesWithPrototypeFabric() throws {
    XCTAssertEqual(
      Day02.boxesWithPrototypeFabric(boxIDs: [
        "abcde",
        "fghij",
        "klmno",
        "pqrst",
        "fguij",
        "axcye",
        "wvxyz",
      ]), "fgij")
  }

  func testCharacterCounts() throws {
    XCTAssertEqual(
      Day02.characterCounts("abcdef"), ["a": 1, "b": 1, "c": 1, "d": 1, "e": 1, "f": 1])
    XCTAssertEqual(
      Day02.characterCounts("bababc"), ["a": 2, "b": 3, "c": 1])
    XCTAssertEqual(
      Day02.characterCounts("abbcde"), ["a": 1, "b": 2, "c": 1, "d": 1, "e": 1])
    XCTAssertEqual(
      Day02.characterCounts("abcccd"), ["a": 1, "b": 1, "c": 3, "d": 1])
    XCTAssertEqual(
      Day02.characterCounts("aabcdd"), ["a": 2, "b": 1, "c": 1, "d": 2])
    XCTAssertEqual(
      Day02.characterCounts("abcdee"), ["a": 1, "b": 1, "c": 1, "d": 1, "e": 2])
    XCTAssertEqual(
      Day02.characterCounts("ababab"), ["a": 3, "b": 3])
  }

  func testChecksum() throws {
    let ids = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
    XCTAssertEqual(Day02.checksum(ids), 12)
  }

  func testHamming() throws {
    XCTAssertEqual(Day02.hamming(lhs: "abcde", rhs: "axcye"), 2)
    XCTAssertEqual(Day02.hamming(lhs: "fghij", rhs: "fguij"), 1)
  }

  func testLikelyCandidate() throws {
    XCTAssertEqual(Day02.likelyCandidate("abcdef"), Candidate(is2: false, is3: false))
    XCTAssertEqual(Day02.likelyCandidate("bababc"), Candidate(is2: true, is3: true))
    XCTAssertEqual(Day02.likelyCandidate("abbcde"), Candidate(is2: true, is3: false))
    XCTAssertEqual(Day02.likelyCandidate("abcccd"), Candidate(is2: false, is3: true))
    XCTAssertEqual(Day02.likelyCandidate("aabcdd"), Candidate(is2: true, is3: false))
    XCTAssertEqual(Day02.likelyCandidate("abcdee"), Candidate(is2: true, is3: false))
    XCTAssertEqual(Day02.likelyCandidate("ababab"), Candidate(is2: false, is3: true))
  }
}
