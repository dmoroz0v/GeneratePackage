// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import Foundation
import ArgumentParser

let graph_d = """
AA:I
BB:AA
CC:AA
DD:BB
EE:DD
FF:DD
GG:CC
HH:FF
II:FF
"""

let countFilesInModule = 100

let packageTemplate = """
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
        __TARGETS__
        .target(
            name: "UmbrellaTarget",
            dependencies: [
                __TARGETS_LIST__
            ]
        ),
    ]
)
"""

let targetTemplate = """
        .target(
            name: "__TARGET_NAME__",
            dependencies: [
                __DEPS__
            ]
        ),
"""

func createEntityFile0(path: URL, module: String, suffix: String) throws {
    let template = """

open class \(module)Entity\(suffix) {

    public init() {}

    open func foo() {
    }
}
"""

    let fileName = "\(module)Entity\(suffix).swift"
    let fileURL = path.appendingPathComponent(fileName)

    try template.write(to: fileURL, atomically: true, encoding: .utf8)
}

func createEntityFile(path: URL, module: String, dep: String, suffix: String) throws {
    let template = """
import \(dep)

open class \(module)Entity\(suffix): \(dep)Entity\(suffix) {

    open override func foo() {
        super.foo()
    }
}
"""

    let fileName = "\(module)Entity\(suffix).swift"
    let fileURL = path.appendingPathComponent(fileName)

    try template.write(to: fileURL, atomically: true, encoding: .utf8)
}


@main
struct MyTool: @preconcurrency ParsableCommand {

    @MainActor
    static var configuration = CommandConfiguration(
        commandName: "generate",
        abstract: "Generates files at specified path"
    )

    @Argument(help: "")
    var relativePath: String

    @Argument(help: "")
    var deep: Int

    mutating func run() throws {

        var graph = """
        A
        B:A
        C:A
        D:B
        E:D
        F:D
        G:C
        H:F
        I:F
        """

        graph += "\n" + graph_d

        var graph_d = graph_d

        for _ in 0..<deep {
            var new_graph_d: [String] = []

            for line in graph_d.split(separator: "\n") {
                let newLine = String(line.first!) + String(line) + String(line.last!)
                new_graph_d.append(newLine)
            }

            graph_d = new_graph_d.joined(separator: "\n")

            graph += "\n" + graph_d
        }

        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let pathURL = URL(fileURLWithPath: relativePath, relativeTo: currentDirectoryURL)

        func createDirectoryIfNeeded(at url: URL) throws {
            let fileManager = FileManager.default
            var isDirectory: ObjCBool = false

            if fileManager.fileExists(atPath: url.path, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    // Директория уже существует
                    return
                } else {
                    throw NSError(domain: "FileSystem", code: 1,
                                  userInfo: [NSLocalizedDescriptionKey: "Path exists but is a file: \(url.path)"])
                }
            }

            try fileManager.createDirectory(at: url,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
        }

        let sourcePath = pathURL.appendingPathComponent("Sources")
        try! createDirectoryIfNeeded(at: sourcePath)

        var targets: [String] = []
        var targetsList: [String] = []

        for line in graph.split(separator: "\n") {
            let components = line.split(separator: ":")

            let module = String(components[0])

            targetsList.append("\"" + module + "\"")

            let modulePath = sourcePath.appendingPathComponent(module)
            try! createDirectoryIfNeeded(at: modulePath)

            if components.count == 1 {
                for i in 0..<countFilesInModule {
                    try! createEntityFile0(path: modulePath, module: module, suffix: "\(i)")
                }
                targets.append(
                    targetTemplate
                        .replacingOccurrences(of: "__TARGET_NAME__", with: module)
                        .replacingOccurrences(of: "__DEPS__", with: "")
                )
            } else {
                let dep = String(components[1])
                for i in 0..<countFilesInModule {
                    try! createEntityFile(path: modulePath, module: module, dep: dep, suffix: "\(i)")
                }
                targets.append(
                    targetTemplate
                        .replacingOccurrences(of: "__TARGET_NAME__", with: module)
                        .replacingOccurrences(of: "__DEPS__", with: "\"" + dep + "\"")
                )
            }
        }

        try! packageTemplate
            .replacingOccurrences(
                of: "__TARGETS__",
                with: targets.joined(separator: "\n")
            )
            .replacingOccurrences(
                of: "__TARGETS_LIST__",
                with: targetsList.joined(separator: ",\n                ")
            )
            .write(
                to: pathURL.appendingPathComponent("Package.swift"),
                atomically: true,
                encoding: .utf8
            )
    }
}
