// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NER",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "NER",
            targets: ["NER"]),
    ],
    dependencies: [
        .package(name: "AnnotatedSentence", url: "https://github.com/StarlangSoftware/AnnotatedSentence-Swift.git", .exact("1.0.3"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "NER",
            dependencies: ["AnnotatedSentence"]),
        .testTarget(
            name: "NERTests",
            dependencies: ["NER"]),
    ]
)
