# AEGENTIX Mobile Hosts

Platform hosts for iOS and Pixel. These are application-layer nodes; they do not replace or modify the native operating system.

- `ios/` — Swift Package source for the transport, journal, node identity and App Intents integration layer.
- `pixel/` — Kotlin source for transport, journal, node identity and WorkManager integration layer.

Configure the AEGENTIS CORE endpoint at runtime. Do not embed credentials in source control.

Security boundary: no jailbreak/root, no system partition changes, no security bypasses, no carrier-service changes.
