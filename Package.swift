// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZenID",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // ZenID Lite - Core SDK without MS Liveness support
        // Recommended for most apps. Saves ~140MB in app size.
        .library(
            name: "ZenID",
            targets: ["ZenID"]),

        // ZenID Full - Includes MS Liveness with AzureAIVisionFaceUI.xcframework (~140MB additional)
        // Choose this if you need Microsoft Azure Face Liveness verification.
        .library(
            name: "ZenIDFull",
            targets: ["ZenID", "AzureAIVisionFaceUI", "ZenIDMSLiveness"]),
    ],
    dependencies: [],
    targets: [
        // Core ZenID framework (required for all versions)
        // All required models are bundled inside this framework
        .binaryTarget(
            name: "ZenID",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.4.18/ZenID.xcframework.zip", checksum: "15ba27b5062e431e8d3c069931da6e2c345236fb4710848a59e75eea30122b74"),

        // Azure AI Vision Face UI framework (optional, only needed for MS Liveness)
        // Adds ~140MB to app size
        .binaryTarget(
            name: "AzureAIVisionFaceUI",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.4.18/AzureAIVisionFaceUI.xcframework.zip", checksum: "bd4e8e28b6f90b8f06e0fdf45fee23d1d47214595d0aa9764699658703ec0d93"),

        // MS Liveness integration helpers (SwiftUI + UIKit). Source target — it depends on
        // AzureAIVisionFaceUI, so it ships only in the ZenIDFull product; the Lite ZenID
        // product stays free of the optional Azure dependency.
        .target(
            name: "ZenIDMSLiveness",
            dependencies: ["ZenID", "AzureAIVisionFaceUI"],
            path: "MSLivenessHelpers",
            exclude: ["MSLivenessViewModel.swift", "README.md"]),
    ]
)
