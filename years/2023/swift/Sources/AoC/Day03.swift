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

public class Day03: Day {
  public init() {}

  struct Candidate: Hashable {
    let number: String
    let lineno: Int
    let range: Range<String.Index>
  }

  struct Symbol: Hashable {
    let s: String
    let lineno: Int
    let line: String
    let range: Range<String.Index>
  }

  public func part1(_ input: Input) {
    let data = input.asStringArray()

    let (candidates, symbols) = Day03.parseData(data: data)
    var parts: Set<Candidate> = []

    for symbol in symbols {
      parts.formUnion(Day03.partsForSymbol(candidates: candidates, symbol: symbol))
    }

    print("day 03 part 1: \(Day03.score(parts))")
  }

  public func part2(_ input: Input) {
    let data = input.asStringArray()

    print("day 03 part 2: \(data.count)")
  }

  static func parseData(data: [String]) -> (Set<Candidate>, Set<Symbol>) {
    var candidates: Set<Candidate> = []
    var symbols: Set<Symbol> = []

    for (ln, line) in data.enumerated() {
      for rc in line.ranges(of: #/\d+/#) {
        candidates.insert(Day03.Candidate(number: String(line[rc]), lineno: ln, range: rc))
      }

      for rs in line.ranges(of: #/[^\d.]/#) {
        symbols.insert(Symbol(s: String(line[rs]), lineno: ln, line: line, range: rs))
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
      })
    )

    // middle
    parts.formUnion(
      candidates.filter({
        $0.range.overlaps(symbol.range)
          && vr.contains($0.lineno)
      })
    )

    // right
    parts.formUnion(
      candidates.filter({
        $0.range.contains(symbol.line.index(after: symbol.range.lowerBound))
          && vr.contains($0.lineno)
      })
    )

    return parts
  }

  static func score(_ parts: Set<Candidate>) -> Int {
    parts.map({ Int($0.number)! }).sum()
  }
}
