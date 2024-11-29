/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import CoreLibraries
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

  func testPart2() throws {
    let almanac = Day05.parseAlmanac(data)
    let seeds = Array(almanac.seeds)
    let locations = seeds.chunks(ofCount: 2).map({ pair in
      let lowerBound = pair[pair.startIndex]
      let upperBound = lowerBound + pair[pair.endIndex - 1]
      let range = lowerBound..<upperBound
      return range.map({ Day05.seedLocation(seed: $0, almanac: almanac) }).min()!
    })

    XCTAssertEqual(locations.min()!, 46)
  }

  func testMapSeed() throws {
    let map = [50..<98: 52..<100, 98..<100: 50..<52]
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
        seeds: [79, 14, 55, 13],
        seedToSoil: [98..<100: 50..<52, 50..<98: 52..<100],
        soilToFertilizer: [15..<52: 0..<37, 52..<54: 37..<39, 0..<15: 39..<54],
        fertilizerToWater: [7..<11: 57..<61, 11..<53: 0..<42, 53..<61: 49..<57, 0..<7: 42..<49],
        waterToLight: [18..<25: 88..<95, 25..<95: 18..<88],
        lightToTemperature: [64..<77: 68..<81, 45..<64: 81..<100, 77..<100: 45..<68],
        temperatureToHumidity: [0..<69: 1..<70, 69..<70: 0..<1],
        humidityToLocation: [93..<97: 56..<60, 56..<93: 60..<97]
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
        98..<100: 50..<52,
        50..<98: 52..<100,
      ])
  }

  func testParseMapLine() throws {
    XCTAssertEqual(Day05.parseMapLine("50 98 2"), [98..<100: 50..<52])
    XCTAssertEqual(Day05.parseMapLine("52 50 48"), [50..<98: 52..<100])
  }

  func testSeedLocation() throws {
    let almanac = Day05.parseAlmanac(data)

    XCTAssertEqual(Day05.seedLocation(seed: 79, almanac: almanac), 82)
    XCTAssertEqual(Day05.seedLocation(seed: 14, almanac: almanac), 43)
    XCTAssertEqual(Day05.seedLocation(seed: 55, almanac: almanac), 86)
    XCTAssertEqual(Day05.seedLocation(seed: 13, almanac: almanac), 35)
  }
}
