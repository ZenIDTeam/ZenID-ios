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
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.3.14/ZenID.xcframework.zip", checksum: "a10d07a69edad7b1041a1cdd372f36a1c6421e8b02a8bf64b757b3a4754b1f1b"),

        // Azure AI Vision Face UI framework (optional, only needed for MS Liveness)
        // Adds ~140MB to app size
        .binaryTarget(
            name: "AzureAIVisionFaceUI",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.3.14/AzureAIVisionFaceUI.xcframework.zip", checksum: "405c0f912b5c723a2a5a338f37dc26a7367038eb6ab7ea017468ba14b66b6d5f"),

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
