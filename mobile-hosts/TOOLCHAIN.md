# AEGENTIX Mobile Host Toolchain

## iOS
Build machine: macOS + Xcode 26 or newer + iOS 26 SDK for App Store submission. Xcode 26 is the current submission baseline as of April 28, 2026. Local deployment to a physical device can use a free Apple Account; App Store distribution requires Apple Developer Program membership.

Project generation uses XcodeGen. The generated Xcode project is intentionally not committed so the project remains reproducible from `ios/project.yml`.

## Pixel
- Android Studio stable
- JDK 17
- Android SDK Platform 36
- Build Tools 36.0.0
- Android Gradle Plugin 9.0.1
- Gradle 9.1.0
- Kotlin 2.2.21

AGP 9.0.1 requires JDK 17 and Gradle 9.1.0. Do not install a second arbitrary JDK for the build.

## Host machine note
The Pixel project can be built on Windows/Linux/macOS. iOS application compilation/signing requires macOS/Xcode.
