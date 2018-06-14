// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "errands",
  products: [
    .library(name: "Errands", targets: ["Errands"]),
  ],
  targets: [
    .target(name: "Errands", dependencies: []),
    .testTarget(name: "errandsTests", dependencies: ["Errands"]),
  ],
  swiftLanguageVersions: [3]
)
