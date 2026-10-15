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
            targets: ["ZenIDDeps"]),

        // ZenID Full - Includes MS Liveness with AzureAIVisionFaceUI.xcframework (~140MB additional)
        // Choose this if you need Microsoft Azure Face Liveness verification.
        .library(
            name: "ZenIDFull",
            targets: ["ZenIDDeps", "AzureAIVisionFaceUI", "ZenIDMSLiveness"]),
    ],
    dependencies: [
        // Floor is deliberately above NFCPassportReader's own >= 3.6.0001: that tag is OpenSSL 3.6.0,
        // still affected by the 2026 CVEs. 3.6.5000 is OpenSSL 3.6.5.
        .package(
            url: "https://github.com/krzyzanowskim/OpenSSL-Package.git",
            .upToNextMinor(from: "3.6.5000")),

        // NFCPassportReader is exposed in ZenID.framework's public API (NFCDocumentModelType uses DGName).
        // Version must match sdk/iOS/ZenID.xcodeproj to ensure ABI compatibility.
        // 2.3.2+ is required - older versions cap OpenSSL at < 3.4.0.
        .package(
            url: "https://github.com/AndyQ/NFCPassportReader.git",
            .upToNextMajor(from: "2.3.3")),
    ],
    targets: [
        // Wrapper target so the ZenID library product transitively links OpenSSL.framework,
        // which the binary ZenID.xcframework references at runtime via NFCPassportReader.
        .target(
            name: "ZenIDDeps",
            dependencies: [
                "ZenID",
                .product(name: "OpenSSL", package: "OpenSSL-Package"),
                .product(name: "NFCPassportReader", package: "NFCPassportReader"),
            ],
            path: "Sources/ZenIDDeps"),

        // Core ZenID framework (required for all versions)
        // All required models are bundled inside this framework
        .binaryTarget(
            name: "ZenID",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.5.14/ZenID.xcframework.zip", checksum: "5bdaa8fdab69f54deef98083b0fc8798db0839605913dcbf7b32842ca9e3d82d"),

        // Azure AI Vision Face UI framework (optional, only needed for MS Liveness)
        // Adds ~140MB to app size
        .binaryTarget(
            name: "AzureAIVisionFaceUI",
            url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.5.14/AzureAIVisionFaceUI.xcframework.zip", checksum: "afba53e78eccc06351958fe919e85239565c3e524324dedb31aa1c078e0c8fec"),

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

// download_frameworks.sh manual-integration source: OpenSSL.xcframework.zip url: "https://github.com/ZenIDTeam/ZenID-ios/releases/download/5.5.14/OpenSSL.xcframework.zip", checksum: "3765d0e825f4d5eb0f60397081ca676c65153ee55bb8faff9e5d247023cca47f"
