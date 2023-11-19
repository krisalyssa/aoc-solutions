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

class TestDay01: XCTestCase {
  func testCalculateFuel() async throws {
    XCTAssertEqual(Day01.calculateFuel(mass: 12), 2)
    XCTAssertEqual(Day01.calculateFuel(mass: 14), 2)
    XCTAssertEqual(Day01.calculateFuel(mass: 1969), 654)
    XCTAssertEqual(Day01.calculateFuel(mass: 100_756), 33_583)
  }

  func testCalculateAllFuel() throws {
    XCTAssertEqual(Day01.calculateAllFuel(mass: 14), 2)
    XCTAssertEqual(Day01.calculateAllFuel(mass: 1969), 966)
    XCTAssertEqual(Day01.calculateAllFuel(mass: 100_756), 50_346)
  }
}
