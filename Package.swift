// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "StudAppServer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.1.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", .upToNextMinor(from: "6.0.0")),
        .package(url: "https://github.com/IBM-Swift/Configuration.git", .upToNextMinor(from: "3.0.0")),
        .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", .upToNextMinor(from: "1.8.4")),
        .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
        .package(url: "https://github.com/BennyKJohnson/OpenCloudKit.git", .upToNextMinor(from: "0.5.9")),
    ],
    targets: [
        .target(name: "StudAppServer", dependencies: [
            "Kitura",
            "HeliumLogger",
            "Configuration",
            "CloudEnvironment",
            "SwiftMetrics",
            "Health",
            "KituraStencil",
            "OpenCloudKit",
        ]),
        .testTarget(name: "StudAppServerTests", dependencies: [
            .target(name: "StudAppServer"),
            "Kitura",
            "HeliumLogger",
        ]),
    ]
)
