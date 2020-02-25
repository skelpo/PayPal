// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "PayPal",
    products: [
        .library(name: "PayPal", targets: ["PayPal"]),
    ],
    dependencies: [
        .package(url: "https://github.com/skelpo/Countries.git", from: "1.0.0"),
        .package(url: "https://github.com/skelpo/Failable.git", from: "0.4.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),
        .package(url: "https://github.com/skelpo/JSON.git", from: "1.0.0"),
        .package(url: "https://github.com/twostraws/SwiftGD.git", from: "2.2.0")
    ],
    targets: [
        .target(name: "PayPal", dependencies: ["Vapor", "JSON", "Failable", "Countries"]),
        .target(name: "PayPalV1", dependencies: ["Vapor", "PayPal"], path: "Sources/V1"),
        .target(name: "PayPalV2", dependencies: ["Vapor", "PayPal"], path: "Sources/V2"),
        
        .target(name: "TestUtilities", dependencies: ["PayPal", "Vapor"]),
        .testTarget(name: "ConfigTests", dependencies: ["PayPal", "TestUtilities"]),
        .testTarget(name: "ControllerTests", dependencies: ["PayPal", "SwiftGD", "TestUtilities"]),
        .testTarget(name: "ModelTests", dependencies: ["PayPal", "TestUtilities"]),
        .testTarget(name: "PayPalTests", dependencies: ["PayPal", "Vapor", "JSON", "ConfigTests", "ControllerTests", "ModelTests"]),
    ]
)
