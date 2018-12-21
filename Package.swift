// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "PayPal",
    products: [
        .library(name: "PayPal", targets: ["PayPal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/skelpo/Countries.git", from: "0.9.1"),
        .package(url: "https://github.com/skelpo/Failable.git", from: "0.2.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.1.0"),
        .package(url: "https://github.com/skelpo/JSON.git", from: "0.13.1"),
        .package(url: "https://github.com/twostraws/SwiftGD.git", from: "2.2.0")
    ],
    targets: [
        .target(name: "PayPal", dependencies: ["Vapor", "JSON", "Failable", "Countries"]),
        
        .target(name: "TestsUtilities", dependencies: ["PayPal", "Vapor"]),
        .testTarget(name: "ConfigTests", dependencies: ["PayPal", "TestsUtilities"]),
        .testTarget(name: "ControllerTests", dependencies: ["PayPal", "SwiftGD", "TestsUtilities"]),
        .testTarget(name: "ModelTests", dependencies: ["PayPal"]),
        .testTarget(name: "PayPalTests", dependencies: ["PayPal", "Vapor", "JSON"]),
    ]
)
