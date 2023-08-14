// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RemoteImage",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "RemoteImage",
            targets: ["RemoteImage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "RemoteImage",
            dependencies: [
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "RemoteImageTests",
            dependencies: ["RemoteImage"]
         ),
    ],
    swiftLanguageVersions: [ .version("5.1") ]
)
