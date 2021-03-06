// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-hello",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .systemLibrary(
            name: "CWaylandClient",
            pkgConfig: "wayland-client",
            providers: [
                .brew(["wayland-client"]),
                .apt(["wayland-client"])
            ]
        ),
        .systemLibrary(
            name: "CWaylandEGL",
            pkgConfig: "wayland-egl",
            providers: [
                .brew(["wayland-egl"]),
                .apt(["wayland-egl"])
            ]
        ),
        .target(
            name: "swift-hello",
            dependencies: ["CWaylandClient", "CWaylandEGL"]),
        .testTarget(
            name: "swift-helloTests",
            dependencies: ["swift-hello"]),
    ]
)
