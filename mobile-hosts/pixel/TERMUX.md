# AEGENTIX Pixel — phone-only integration

The Pixel iteration is designed so the phone can be used as both the AEGENTIX endpoint and its local operator terminal.

## Local toolchain

Install Termux from the official F-Droid/GitHub distribution. Do not use a random APK mirror.

Inside Termux, the supported preparation sequence is:

```sh
pkg update && pkg upgrade
pkg install git curl openssh jq python nodejs
termux-setup-storage
git clone https://github.com/shalominattii-us/AEGENTIX-DEVTOOLS.git
cd AEGENTIX-DEVTOOLS/mobile-hosts/pixel
```

The native APK is built by the repository CI pipeline. Termux is the local AEGENTIX control/development environment; it is not used as a replacement for Android's signed application package.

## Device integration gates

1. Termux installation and repository access.
2. Android Developer Options.
3. USB debugging only if an external development machine is used; it is not required for the phone-only path.
4. Install the signed AEGENTIX APK.
5. Grant only the permissions required by the capability registry.
6. Generate/persist the AEGENTIX node identity.
7. Configure the CORE endpoint.
8. Enroll the node.
9. Verify authenticated heartbeat.
10. Verify Guardian-gated command/result flow.
11. Verify event journal and offline queue.
12. Disable/re-enable network and verify replay/reconciliation.
13. Restart the app and verify continuity.

No root is required for this integration path. Platform-provided Android APIs and user-granted permissions are the authority boundary.
