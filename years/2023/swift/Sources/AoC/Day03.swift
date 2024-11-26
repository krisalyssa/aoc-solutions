/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham.
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import AoCCommon
import AoCExtensions
import CoreLibraries

public class Day03: Day {
  public init() {}

  struct Candidate: Hashable {
    let number: String
    let lineno: Int
    let range: Range<String.Index>
    let symbol: Symbol?
  }

  struct Symbol: Hashable {
    let s: String
    let lineno: Int
    let line: String
    let range: Range<String.Index>
    var parts: Set<Candidate>
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    var (candidates, symbols) = Day03.parseData(data: data)

    symbols = Set(
      symbols.map {
        let p = Day03.partsForSymbol(candidates: candidates, symbol: $0)
        return Symbol(s: $0.s, lineno: $0.lineno, line: $0.line, range: $0.range, parts: p)
      })

    let parts = symbols.reduce(
      Set<Candidate>(),
      { acc, element in
        return acc.union(element.parts)
      })

    print("day 03 part 1: \(Day03.score(parts))")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    var (candidates, symbols) = Day03.parseData(data: data)

    symbols = Set(
      symbols.map {
        let p = Day03.partsForSymbol(candidates: candidates, symbol: $0)
        return Symbol(s: $0.s, lineno: $0.lineno, line: $0.line, range: $0.range, parts: p)
      })

    let gears = symbols.filter { $0.s == "*" && $0.parts.count == 2 }
    let sum = gears.map({ Day03.gearRatio(gear: $0) }).sum()

    print("day 03 part 2: \(sum)")
  }

  static func gearRatio(gear: Symbol) -> Int {
    gear.parts.map({ Int($0.number)! }).reduce(1, *)
  }

  static func parseData(data: [String]) -> (Set<Candidate>, Set<Symbol>) {
    var candidates: Set<Candidate> = []
    var symbols: Set<Symbol> = []

    for (ln, line) in data.enumerated() {
      for rc in line.ranges(of: #/\d+/#) {
        candidates.insert(
          Day03.Candidate(number: String(line[rc]), lineno: ln, range: rc, symbol: nil)
        )
      }

      for rs in line.ranges(of: #/[^\d.]/#) {
        symbols.insert(Symbol(s: String(line[rs]), lineno: ln, line: line, range: rs, parts: []))
      }
    }

    return (candidates, symbols)
  }

  static func partsForSymbol(candidates: Set<Candidate>, symbol: Symbol) -> Set<Candidate> {
    var parts: Set<Candidate> = []
    let vr = (symbol.lineno - 1)...(symbol.lineno + 1)

    // left
    parts.formUnion(
      candidates.filter({
        $0.range.contains(symbol.line.index(before: symbol.range.lowerBound))
          && vr.contains($0.lineno)
      }).map { Candidate(number: $0.number, lineno: $0.lineno, range: $0.range, symbol: symbol) }
    )

    // middle
    parts.formUnion(
      candidates.filter({
        $0.range.overlaps(symbol.range)
          && vr.contains($0.lineno)
      }).map { Candidate(number: $0.number, lineno: $0.lineno, range: $0.range, symbol: symbol) }
    )

    // right
    parts.formUnion(
      candidates.filter({
        $0.range.contains(symbol.line.index(after: symbol.range.lowerBound))
          && vr.contains($0.lineno)
      }).map { Candidate(number: $0.number, lineno: $0.lineno, range: $0.range, symbol: symbol) }
    )

    return parts
  }

  static func score(_ parts: Set<Candidate>) -> Int {
    parts.map({ Int($0.number)! }).sum()
  }
}
