// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "PayPal",
    products: [
        .library(name: "PayPal", targets: ["PayPal"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "PayPal", dependencies: []),
        .testTarget(name: "PayPalTests", dependencies: ["PayPal"]),
    ]
)
