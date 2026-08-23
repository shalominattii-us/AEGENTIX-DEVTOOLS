#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT/ios"
command -v xcodebuild >/dev/null || { echo 'Xcode is required on macOS.'; exit 1; }
if ! command -v xcodegen >/dev/null; then
  command -v brew >/dev/null || { echo 'Install Homebrew or XcodeGen manually.'; exit 1; }
  brew install xcodegen
fi
xcodegen generate
xcodebuild -project AegentixHost.xcodeproj -scheme AegentixHost -sdk iphonesimulator -configuration Debug build CODE_SIGNING_ALLOWED=NO
