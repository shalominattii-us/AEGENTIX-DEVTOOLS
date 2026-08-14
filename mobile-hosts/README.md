# AEGENTIX Mobile Hosts

Application-layer AEGENTIX hosts for iOS and Pixel. Native OS security remains authoritative; these hosts do not jailbreak, root, replace, or modify the underlying operating systems.

## Layout
- `ios/` — Swift/XcodeGen application + host library.
- `pixel/` — Kotlin/Compose Android application.
- `host-console/` — static provisioning/configuration web UI; no secrets are persisted.
- `TOOLCHAIN.md` — exact development toolchain.
- `bootstrap-ios.sh` — generate/build iOS simulator target on macOS.
- `bootstrap-pixel.ps1` — Windows Pixel bootstrap/check script.

## Toolchain
- iOS: macOS + Xcode 26+ / iOS 26 SDK for App Store submission.
- Pixel: JDK 17, Android SDK 36, Build Tools 36.0.0, AGP 9.0.1, Gradle 9.1.0.

## Build
The GitHub Actions workflows build both platforms. iOS requires macOS/Xcode. Pixel can build on Windows/Linux/macOS.

## Runtime boundary
Configure the AEGENTIS CORE endpoint at runtime. Credentials are provisioned out-of-band and must never be committed. Mobile nodes remain constrained execution/presence nodes governed by the AEGENTIX policy/Guardian boundary.
