// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "PayPal",
    products: [
        .library(name: "PayPal", targets: ["PayPal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.5"),
        .package(url: "https://github.com/skelpo/JSON.git", from: "0.13.0")
    ],
    targets: [
        .target(name: "PayPal", dependencies: ["Vapor", "JSON"]),
        .testTarget(name: "PayPalTests", dependencies: ["PayPal", "Vapor", "JSON"]),
    ]
)
