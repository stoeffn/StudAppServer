// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "StudAppServer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", .upToNextMinor(from: "4.0.5")),
        .package(url: "https://github.com/IBM-Swift/Configuration.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Health.git", from: "0.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", .upToNextMinor(from: "1.8.0")),
        .package(url: "https://github.com/BennyKJohnson/OpenCloudKit.git", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        .target(name: "StudAppServer", dependencies: [.target(name: "Application"), "Kitura", "HeliumLogger"]),
        .target(name: "Application", dependencies: [
            "Kitura", "Configuration", "CloudEnvironment", "SwiftMetrics", "Health", "KituraStencil", "OpenCloudKit",
        ]),

        .testTarget(name: "ApplicationTests", dependencies: [.target(name: "Application"), "Kitura", "HeliumLogger"]),
    ]
)
