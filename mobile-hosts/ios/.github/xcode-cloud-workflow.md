# Xcode Cloud workflow checklist

Xcode Cloud configuration is intentionally performed in App Store Connect/Xcode Cloud rather than through a repository-stored signing secret.

## Workflow

- Repository: `shalominattii-us/AEGENTIX-DEVTOOLS`
- Project: `mobile-hosts/ios/AEGENTIX.xcodeproj`
- Scheme: `AEGENTIX`
- Platform: iOS
- Build configuration: Release
- Distribution: TestFlight
- Branch: `feat/mobile-hosts-ios-pixel` until the mobile-host PR is merged

## Required Apple configuration

- Apple Developer Program membership
- App Store Connect app record
- Bundle identifier registered in the Apple Developer account
- Signing team selected for the project
- Required app capabilities enabled in the App ID and Xcode project
- Xcode Cloud repository authorization
- TestFlight internal tester configured

## Security

Never commit `.p8` private keys, certificates, provisioning profiles, passwords, or App Store Connect secrets. Keep signing and distribution credentials in Apple's managed signing/Xcode Cloud configuration.

## Verification

A successful Xcode Cloud archive/TestFlight upload proves Apple-side packaging/distribution. It does not prove physical-device runtime behavior. Physical-device verification begins only after the build is installed on the iPhone 17e.
