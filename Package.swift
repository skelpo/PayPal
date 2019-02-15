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
        
        .target(name: "TestUtilities", dependencies: ["PayPal", "Vapor"]),
        .testTarget(name: "ConfigTests", dependencies: ["PayPal", "TestUtilities"]),
        .testTarget(name: "ControllerTests", dependencies: ["PayPal", "SwiftGD", "TestUtilities"]),
        .testTarget(name: "ModelTests", dependencies: ["PayPal", "TestUtilities"]),
        .testTarget(name: "PayPalTests", dependencies: ["PayPal", "Vapor", "JSON", "ConfigTests", "ControllerTests", "ModelTests"]),
    ]
)
