// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecipeKit",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "RecipeKit",
            targets: ["RecipeKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RecipeKit",
            dependencies: [],
            resources: [.process("Resources")]),
        .testTarget(
            name: "RecipeKitTests",
            dependencies: ["RecipeKit"]),
    ]
)
