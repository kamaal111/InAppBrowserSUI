// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InAppBrowserSUI",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "InAppBrowserSUI",
            targets: ["InAppBrowserSUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "InAppBrowserSUI",
            dependencies: []),
        .testTarget(
            name: "InAppBrowserSUITests",
            dependencies: ["InAppBrowserSUI"]),
    ]
)
