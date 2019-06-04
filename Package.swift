// swift-tools-version:5.0
//
//  Package.swift
//  Lumber
//
//  Created by Aaron Wright on 5/1/18.
//  Copyright © 2018 Aaron Wright. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Token",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "Token",
            targets: ["Token"])
    ],
    targets: [
        .target(
            name: "Token",
            path: "Sources"),
        .testTarget(
            name: "TokenTests",
            dependencies: ["Token"],
            path: "Tests"),
    ],
    swiftLanguageVersions: [.v5]
)

