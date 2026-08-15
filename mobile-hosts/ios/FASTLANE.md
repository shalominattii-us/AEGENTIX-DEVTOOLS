# iPhone 17e Apple delivery path

AEGENTIX does not require a local Mac for the delivery path. The source remains in GitHub; Apple-side signing/build/distribution is performed through Xcode Cloud/App Store Connect.

## One-time Apple setup

1. Enroll in the Apple Developer Program.
2. Create the App ID/bundle identifier used by `mobile-hosts/ios/AEGENTIX.xcodeproj`.
3. Create the App Store Connect app record with the same bundle identifier.
4. Enable Xcode Cloud for the repository/project in App Store Connect.
5. Grant Xcode Cloud access to the GitHub repository.
6. Configure the required signing team/capabilities in the Xcode project.
7. Create a TestFlight build workflow targeting the iOS application scheme.

## Device path

GitHub -> Xcode Cloud -> signed archive -> TestFlight -> iPhone 17e.

The iPhone remains untouched until the signed build is available. Do not place certificates, provisioning profiles, App Store Connect API private keys, or signing secrets in this repository.

## Runtime gate

After installation, verify in order: launch, node identity, capability discovery, CORE enrollment, authenticated heartbeat, Guardian-gated command, event acknowledgement, offline queue, reconnect/replay, restart recovery, and causal reconciliation.

This document intentionally does not contain secrets or claim physical-device verification.
