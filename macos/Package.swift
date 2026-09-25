// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "BochaSwitcher",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "BochaSwitcher",
            path: "Sources/BochaSwitcher",
            linkerSettings: [
                .linkedFramework("AppKit"),
                .linkedFramework("Carbon"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("ServiceManagement"),
            ]
        )
    ]
)
