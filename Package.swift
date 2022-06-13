// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RecogLib_iOS",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "RecogLib_iOS",
            targets: ["RecogLib_iOS"]),
        .library(
            name: "LibZenid_iOS",
            targets: ["LibZenid_iOS"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "RecogLib_iOS",
            path: "./Sources/RecogLib_iOS.xcframework"),
        .binaryTarget(
            name: "LibZenid_iOS",
            path: "./Sources/LibZenid_iOS.xcframework"),
    ]
)
