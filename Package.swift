// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InAppBrowserSUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "InAppBrowserSUI",
            targets: ["InAppBrowserSUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "InAppBrowserSUI",
            dependencies: []),
        .testTarget(
            name: "InAppBrowserSUITests",
            dependencies: ["InAppBrowserSUI"]),
    ]
)
