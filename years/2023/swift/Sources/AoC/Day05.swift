/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCommon
import AoCExtensions
import CoreLibraries

typealias Map = [Range<Int>: Range<Int>]

public struct Almanac: Equatable {
  let seeds: [Int]
  let seedToSoil: Map
  let soilToFertilizer: Map
  let fertilizerToWater: Map
  let waterToLight: Map
  let lightToTemperature: Map
  let temperatureToHumidity: Map
  let humidityToLocation: Map
}

public class Day05: Day {
  public init() {}

  public func part1(_ input: Input) {
    let data = input.asStringArray(withBlankLines: true)

    let almanac = Day05.parseAlmanac(data)
    let minLocation = almanac.seeds.map({ Day05.seedLocation(seed: $0, almanac: almanac) }).min()!

    print("day 05 part 1: \(minLocation)")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray(withBlankLines: true)

    // I don't like brute-forcing this.
    // I have a better algorithm in mind, but I haven't figured out how to implement it yet.
    // Basically, instead of passing seeds through one at a time, pass whole ranges,
    // splitting and mapping them as needed, then return the lowest lowerBound.

    let almanac = Day05.parseAlmanac(data)
    let seeds = Array(almanac.seeds)
    let locations = seeds.chunks(ofCount: 2).map({ pair in
      let lowerBound = pair[pair.startIndex]
      let upperBound = lowerBound + pair[pair.endIndex - 1]
      let range = lowerBound..<upperBound
      return range.map({ Day05.seedLocation(seed: $0, almanac: almanac) }).min()!
    })

    print("day 05 part 2: \(locations.min()!)")
  }

  static func mapSeed(seed: Int, map: Map) -> Int {
    let mapping = map.filter({ $0.key.contains(seed) })
    if mapping.isEmpty {
      return seed
    } else {
      let (range, offset) = mapping.first!
      return (seed - range.lowerBound + offset.lowerBound)
    }
  }

  static func parseAlmanac(_ rawData: [String]) -> Almanac {
    var data = Deque<String>(rawData)

    // get rid of leading noise
    while data.first!.prefixMatch(of: #/seeds:/#) == nil {
      _ = data.popFirst()
    }

    // parse seeds line
    let seeds = data.first!.split(separator: ":")[1].trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: #/\s+/#).map({ Int($0)! })
    _ = data.popFirst()

    // parse maps
    let seedToSoil = parseMap(data: &data, name: "seed-to-soil")
    let soilToFertilizer = parseMap(data: &data, name: "soil-to-fertilizer")
    let fertilizerToWater = parseMap(data: &data, name: "fertilizer-to-water")
    let waterToLight = parseMap(data: &data, name: "water-to-light")
    let lightToTemperature = parseMap(data: &data, name: "light-to-temperature")
    let temperatureToHumidity = parseMap(data: &data, name: "temperature-to-humidity")
    let humidityToLocation = parseMap(data: &data, name: "humidity-to-location")

    return Almanac(
      seeds: seeds,
      seedToSoil: seedToSoil,
      soilToFertilizer: soilToFertilizer,
      fertilizerToWater: fertilizerToWater,
      waterToLight: waterToLight,
      lightToTemperature: lightToTemperature,
      temperatureToHumidity: temperatureToHumidity,
      humidityToLocation: humidityToLocation
    )
  }

  static func parseMap(data: inout Deque<String>, name: String) -> Map {
    let regex = Regex<Substring>(verbatim: "\(name) map:")

    // get rid of leading noise
    while !data.isEmpty && data.first!.prefixMatch(of: regex) == nil {
      _ = data.popFirst()
    }

    // get rid of header line
    _ = data.popFirst()

    var map = Map()
    while !data.isEmpty && !data.first!.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
      map.merge(parseMapLine(data.popFirst()!), uniquingKeysWith: { e, _ in e })
    }

    return map
  }

  static func parseMapLine(_ line: String) -> Map {
    let fields = line.trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: #/\s+/#).map { Int($0) }

    if fields.contains(nil) {
      print("error parsing line: \(line)")
      return [0..<1: 0..<1]
    }

    let destinationStart = fields[0]!
    let sourceStart = fields[1]!
    let sourceLength = fields[2]!

    return [
      sourceStart..<sourceStart + sourceLength: destinationStart..<destinationStart + sourceLength
    ]
  }

  static func seedLocation(seed: Int, almanac: Almanac) -> Int {
    let soil = mapSeed(seed: seed, map: almanac.seedToSoil)
    let fertilizer = mapSeed(seed: soil, map: almanac.soilToFertilizer)
    let water = mapSeed(seed: fertilizer, map: almanac.fertilizerToWater)
    let light = mapSeed(seed: water, map: almanac.waterToLight)
    let temperature = mapSeed(seed: light, map: almanac.lightToTemperature)
    let humidity = mapSeed(seed: temperature, map: almanac.temperatureToHumidity)
    let location = mapSeed(seed: humidity, map: almanac.humidityToLocation)
    return location
  }
}
