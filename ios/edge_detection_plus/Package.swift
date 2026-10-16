// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "edge_detection_plus",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "edge-detection-plus", targets: ["edge_detection_plus"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(name: "WeScan", path: "WeScan")
    ],
    targets: [
        .target(
            name: "edge_detection_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "WeScan", package: "WeScan")
            ],
            path: ".",
            exclude: ["WeScan"],
            sources: ["Sources"],
            resources: [.process("Resources")]
        )
    ]
)
