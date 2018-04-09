// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "StudAppServer",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.2.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", from: "7.1.0"),
        .package(url: "https://github.com/IBM-Swift/Health.git", from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", .upToNextMinor(from: "1.9.0")),
        .package(url: "https://github.com/BennyKJohnson/OpenCloudKit.git", .revision("c4a12722b9d19e669975cb12354521dc1c74cd37")),
    ],
    targets: [
        .target(name: "StudAppServer", dependencies: [
            .target(name: "Application"),
            "Kitura",
            "HeliumLogger",
        ]),
        .target(name: "Application", dependencies: [
            "Kitura",
            "CloudEnvironment",
            "Health",
            "KituraStencil",
            "OpenCloudKit",
        ]),

        .testTarget(name: "ApplicationTests", dependencies: [
            .target(name: "Application"),
            "Kitura",
            "HeliumLogger",
        ]),
    ]
)
