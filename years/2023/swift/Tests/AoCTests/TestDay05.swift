/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import Collections
import XCTest

@testable import AoC

class TestDay05: XCTestCase {
  let data = [
    "seeds: 79 14 55 13",
    "",
    "seed-to-soil map:",
    "50 98 2",
    "52 50 48",
    "",
    "soil-to-fertilizer map:",
    "0 15 37",
    "37 52 2",
    "39 0 15",
    "",
    "fertilizer-to-water map:",
    "49 53 8",
    "0 11 42",
    "42 0 7",
    "57 7 4",
    "",
    "water-to-light map:",
    "88 18 7",
    "18 25 70",
    "",
    "light-to-temperature map:",
    "45 77 23",
    "81 45 19",
    "68 64 13",
    "",
    "temperature-to-humidity map:",
    "0 69 1",
    "1 0 69",
    "",
    "humidity-to-location map:",
    "60 56 37",
    "56 93 4",
  ]

  func testMapSeed() throws {
    let map = [50..<98: 52, 98..<100: 50]
    XCTAssertEqual(Day05.mapSeed(seed: 79, map: map), 81)
    XCTAssertEqual(Day05.mapSeed(seed: 14, map: map), 14)
    XCTAssertEqual(Day05.mapSeed(seed: 55, map: map), 57)
    XCTAssertEqual(Day05.mapSeed(seed: 13, map: map), 13)
    XCTAssertEqual(Day05.mapSeed(seed: 99, map: map), 51)
  }

  func testParseAlmanac() throws {
    XCTAssertEqual(
      Day05.parseAlmanac(data),
      Almanac(
        seeds: [14, 55, 13, 79],
        seedToSoil: [98..<100: 50, 50..<98: 52],
        soilToFertilizer: [15..<52: 0, 52..<54: 37, 0..<15: 39],
        fertilizerToWater: [7..<11: 57, 11..<53: 0, 53..<61: 49, 0..<7: 42],
        waterToLight: [18..<25: 88, 25..<95: 18],
        lightToTemperature: [64..<77: 68, 45..<64: 81, 77..<100: 45],
        temperatureToHumidity: [0..<69: 1, 69..<70: 0],
        humidityToLocation: [93..<97: 56, 56..<93: 60]
      ))
  }

  func testParseMap() throws {
    var subdata = Deque<String>([
      "seed-to-soil map:",
      "50 98 2",
      "52 50 48",
      "",
    ])
    XCTAssertEqual(
      Day05.parseMap(data: &subdata, name: "seed-to-soil"),
      [
        98..<100: 50,
        50..<98: 52,
      ])
  }

  func testParseMapLine() throws {
    XCTAssertEqual(Day05.parseMapLine("50 98 2"), [98..<100: 50])
    XCTAssertEqual(Day05.parseMapLine("52 50 48"), [50..<98: 52])
  }

  func testSeedLocation() throws {
    let almanac = Day05.parseAlmanac(data)

    XCTAssertEqual(Day05.seedLocation(seed: 79, almanac: almanac), 82)
    XCTAssertEqual(Day05.seedLocation(seed: 14, almanac: almanac), 43)
    XCTAssertEqual(Day05.seedLocation(seed: 55, almanac: almanac), 86)
    XCTAssertEqual(Day05.seedLocation(seed: 13, almanac: almanac), 35)
  }
}
