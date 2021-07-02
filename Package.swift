// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "URLDecoder",
    defaultLocalization: "en",
    products: [
        .library(
            name: "URLDecoder",
            targets: ["URLDecoder"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "URLDecoder",
            dependencies: []
        ),
        
        .testTarget(
            name: "URLDecoderTests",
            dependencies: ["URLDecoder"],
            exclude: ["gyb"]
        ),
    ]
)
