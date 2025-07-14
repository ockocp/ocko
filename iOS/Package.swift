// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MesDeplacements",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "MesDeplacements",
            targets: ["MesDeplacements"]),
    ],
    dependencies: [
        // Firebase
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0"),
        
        // Google Sign-In
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "7.0.0"),
        
        // Facebook Login
        .package(url: "https://github.com/facebook/facebook-ios-sdk.git", from: "14.0.0"),
        
        // Charts pour les graphiques
        .package(url: "https://github.com/danielgindi/Charts.git", from: "5.0.0"),
        
        // PDF Generation
        .package(url: "https://github.com/WeTransfer/PDFKit.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "MesDeplacements",
            dependencies: [
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseStorage", package: "firebase-ios-sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
                .product(name: "DGCharts", package: "Charts"),
                .product(name: "PDFKit", package: "PDFKit")
            ]),
        .testTarget(
            name: "MesDeplacementsTests",
            dependencies: ["MesDeplacements"]),
    ]
) 