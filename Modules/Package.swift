// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "MyLibraryName",
//            type: .dynamic,
//            type: .static,
            targets: [
                "UmbrellaTarget"
            ]
        )
    ],
    targets: [
                .target(
            name: "A",
            dependencies: [
                
            ]
        ),
        .target(
            name: "B",
            dependencies: [
                "A"
            ]
        ),
        .target(
            name: "C",
            dependencies: [
                "A"
            ]
        ),
        .target(
            name: "D",
            dependencies: [
                "B"
            ]
        ),
        .target(
            name: "E",
            dependencies: [
                "D"
            ]
        ),
        .target(
            name: "F",
            dependencies: [
                "D"
            ]
        ),
        .target(
            name: "G",
            dependencies: [
                "C"
            ]
        ),
        .target(
            name: "H",
            dependencies: [
                "F"
            ]
        ),
        .target(
            name: "I",
            dependencies: [
                "F"
            ]
        ),
        .target(
            name: "AA",
            dependencies: [
                "I"
            ]
        ),
        .target(
            name: "BB",
            dependencies: [
                "AA"
            ]
        ),
        .target(
            name: "CC",
            dependencies: [
                "AA"
            ]
        ),
        .target(
            name: "DD",
            dependencies: [
                "BB"
            ]
        ),
        .target(
            name: "EE",
            dependencies: [
                "DD"
            ]
        ),
        .target(
            name: "FF",
            dependencies: [
                "DD"
            ]
        ),
        .target(
            name: "GG",
            dependencies: [
                "CC"
            ]
        ),
        .target(
            name: "HH",
            dependencies: [
                "FF"
            ]
        ),
        .target(
            name: "II",
            dependencies: [
                "FF"
            ]
        ),
        .target(
            name: "AAA",
            dependencies: [
                "II"
            ]
        ),
        .target(
            name: "BBB",
            dependencies: [
                "AAA"
            ]
        ),
        .target(
            name: "CCC",
            dependencies: [
                "AAA"
            ]
        ),
        .target(
            name: "DDD",
            dependencies: [
                "BBB"
            ]
        ),
        .target(
            name: "EEE",
            dependencies: [
                "DDD"
            ]
        ),
        .target(
            name: "FFF",
            dependencies: [
                "DDD"
            ]
        ),
        .target(
            name: "GGG",
            dependencies: [
                "CCC"
            ]
        ),
        .target(
            name: "HHH",
            dependencies: [
                "FFF"
            ]
        ),
        .target(
            name: "III",
            dependencies: [
                "FFF"
            ]
        ),
        .target(
            name: "AAAA",
            dependencies: [
                "III"
            ]
        ),
        .target(
            name: "BBBB",
            dependencies: [
                "AAAA"
            ]
        ),
        .target(
            name: "CCCC",
            dependencies: [
                "AAAA"
            ]
        ),
        .target(
            name: "DDDD",
            dependencies: [
                "BBBB"
            ]
        ),
        .target(
            name: "EEEE",
            dependencies: [
                "DDDD"
            ]
        ),
        .target(
            name: "FFFF",
            dependencies: [
                "DDDD"
            ]
        ),
        .target(
            name: "GGGG",
            dependencies: [
                "CCCC"
            ]
        ),
        .target(
            name: "HHHH",
            dependencies: [
                "FFFF"
            ]
        ),
        .target(
            name: "IIII",
            dependencies: [
                "FFFF"
            ]
        ),
        .target(
            name: "UmbrellaTarget",
            dependencies: [
                "A",
                "B",
                "C",
                "D",
                "E",
                "F",
                "G",
                "H",
                "I",
                "AA",
                "BB",
                "CC",
                "DD",
                "EE",
                "FF",
                "GG",
                "HH",
                "II",
                "AAA",
                "BBB",
                "CCC",
                "DDD",
                "EEE",
                "FFF",
                "GGG",
                "HHH",
                "III",
                "AAAA",
                "BBBB",
                "CCCC",
                "DDDD",
                "EEEE",
                "FFFF",
                "GGGG",
                "HHHH",
                "IIII"
            ]
        ),
    ]
)