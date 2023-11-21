// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserPreferences",
    platforms: [
        .macOS(.v11),
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "UserPreferences",
            targets: ["UserPreferences"]),
    ],
    targets: [
        .target(
            name: "UserPreferences"),
        .testTarget(
            name: "UserPreferencesTests",
            dependencies: ["UserPreferences"]),
    ]
)
