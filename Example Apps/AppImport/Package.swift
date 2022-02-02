// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "AppImport",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "AppImport", targets: ["AppImport"]),
    ],
    dependencies: [
        .package(name: "SparrowKit", url: "https://github.com/ivanvorobei/SparrowKit", .upToNextMajor(from: "3.5.1")),
        .package(name: "SPDiffable", url: "https://github.com/ivanvorobei/SPDiffable", .upToNextMajor(from: "4.0.1")),
        .package(name: "SPIndicator", path: "SPIndicator")
    ],
    targets: [
        .target(
            name: "AppImport",
            dependencies: [
                .product(name: "SparrowKit", package: "SparrowKit"),
                .product(name: "SPDiffable", package: "SPDiffable"),
                .product(name: "SPIndicator", package: "SPIndicator")
            ]
        ),
    ]
)
