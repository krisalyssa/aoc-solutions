import Foundation

public class Input {
  var rawData: String?

  init(data: String) {
    rawData = data
  }

  init(fromURL: URL) {
    rawData = try? String(contentsOf: fromURL)
  }

  func asString() -> String {
    return rawData!
  }

  func asStringArray() -> [String.SubSequence] {
    return rawData!.split(separator: "\n")
  }

  func asIntArray() -> [Int] {
    return asStringArray().map { Int.init($0)! }
  }
}
