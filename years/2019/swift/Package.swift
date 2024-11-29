// swift-tools-version: 5.9

/******************************************************************************
 **
 ** Copyright (c) 2023-2024 Kris Cottingham
 ** Licensed under the MIT License.
 **
 ** See https://github.com/krisalyssa/swift-aoc-common/blob/main/LICENSE
 ** for license information.
 **
 **/

import PackageDescription

let package = Package(
  name: "Advent of Code",

  products: [
    .executable(name: "advent", targets: ["advent"]),
    .library(name: "AoC", targets: ["AoC"]),
  ],

  dependencies: [
    .package(url: "https://github.com/krisalyssa/swift-aoc-common.git", from: "0.4.0"),
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
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
      dependencies: []),

    .testTarget(name: "AoCTests", dependencies: ["AoC"]),
  ]
)
