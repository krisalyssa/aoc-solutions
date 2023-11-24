// swift-tools-version: 5.9

/******************************************************************************
 **
 ** Copyright (c) 2023 Craig S. Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/CraigCottingham/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import PackageDescription

let package = Package(
  name: "Advent of Code",

  platforms: [.macOS(.v13)],

  products: [
    .executable(name: "advent", targets: ["advent"]),
    .library(name: "AoC", targets: ["AoC"]),
  ],

  dependencies: [
    .package(url: "https://github.com/CraigCottingham/swift-aoc-common.git", from: "0.7.0"),
    // .package(path: "../../../../swift-aoc-common"),
    .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    // .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.2"),
  ],

  targets: [
    .executableTarget(
      name: "advent",
      dependencies: [
        "AoC",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),

    .target(
      name: "AoC",
      dependencies: [
        .product(name: "Common", package: "swift-aoc-common"),
        "CoreLibraries",
      ]),

    .target(
      name: "CoreLibraries",
      dependencies: [
        .product(name: "Algorithms", package: "swift-algorithms")
        // .product(name: "Collections", package: "swift-collections"),
      ]),

    .testTarget(name: "AoCTests", dependencies: ["AoC"]),
  ]
)
