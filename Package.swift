// swift-tools-version: 5.9

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
            targets: ["UserPreferences"]
        ),
    ],
    targets: [
        .target(name: "UserPreferences")
    ]
)
