// swift-tools-version: 5.5
import PackageDescription

let package = Package(
    name: "HeartLoadingView",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "HeartLoadingView",
            targets: ["HeartLoadingView"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HeartLoadingView",
            path: "HeartLoadingView",
            sources: ["Classes"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
