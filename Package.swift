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
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.4.17/ZenID.xcframework.zip", checksum: "2ba341111065b83315718d130f52d14d2c9e4f5bad39007af36c0019ee137549"),

        // Azure AI Vision Face UI framework (optional, only needed for MS Liveness)
        // Adds ~140MB to app size
        .binaryTarget(
            name: "AzureAIVisionFaceUI",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.4.17/AzureAIVisionFaceUI.xcframework.zip", checksum: "cad8e8f0b1fa7cdfe5052d4579b09558b3f15ddfff15dcce1b9c898172ae0680"),

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
