// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AegentixMobileHost",
    platforms: [.iOS(.v17)],
    products: [.library(name: "AegentixMobileHost", targets: ["AegentixMobileHost"])],
    targets: [.target(name: "AegentixMobileHost")]
)
