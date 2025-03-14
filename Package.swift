// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "PolymatiksAnalytics",
    platforms: [
        .iOS(.v14) // Minimum iOS version
    ],
    products: [
        .library(
            name: "PolymatiksAnalytics",
            targets: ["PolymatiksAnalytics"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.0.0") // Firebase dependency
    ],
    targets: [
        .target(
            name: "PolymatiksAnalytics",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk")
            ],
            path: "Sources/PolymatiksAnalytics"
        ),
        .testTarget(
            name: "PolymatiksAnalyticsTests",
            dependencies: ["PolymatiksAnalytics"],
            path: "Tests"
        ),
    ]
)