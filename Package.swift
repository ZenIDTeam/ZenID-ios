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
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.3.8/ZenID.xcframework.zip", checksum: "f2542b6eac54c7182a79d8d26a56e6c80657a5eb101daf0fd04febaba21d355d"),

        // Azure AI Vision Face UI framework (optional, only needed for MS Liveness)
        // Adds ~140MB to app size
        .binaryTarget(
            name: "AzureAIVisionFaceUI",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.3.8/AzureAIVisionFaceUI.xcframework.zip", checksum: "5cd84a4eb8b82ce717159ec9679dbb6daf06e651fe6161f6cdd623216e60e4e7"),

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
