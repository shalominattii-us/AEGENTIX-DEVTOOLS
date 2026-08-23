# AEGENTIX Pixel integration gate

## Phase A — phone preparation

- Install Termux from F-Droid or the official Termux GitHub distribution.
- Update packages.
- Install Git, OpenSSH, curl, jq, Python and Node.js.
- Clone AEGENTIX-DEVTOOLS.
- Keep the Android APK delivery separate from the Termux control environment.

## Phase B — Android host

- Install the CI-produced signed APK.
- Launch once.
- Confirm the node ID is generated and retained locally.
- Configure the AEGENTIS CORE endpoint.
- Confirm the capability registry reports actual Android capabilities rather than assumptions.

## Phase C — CORE verification

- Enroll node.
- Verify authenticated heartbeat.
- Send a harmless Guardian-approved test command.
- Verify the device result returns to CORE.
- Confirm event-first persistence.

## Phase D — continuity

- Disable network.
- Generate test events.
- Confirm local queue grows.
- Restore network.
- Confirm replay.
- Confirm no duplicate event IDs.
- Confirm causal reconciliation.
- Restart the application and confirm node identity/state recovery.

## Phase E — device agency

For each Android capability exposed by the application, test:

`discover -> permission -> execute -> observe -> journal -> report`

The test is considered passed only when the observed result matches the actual device result. No capability is inferred from API presence alone.

## Gate

Pixel is fully verified only after all phases pass. The iPhone 17e Apple delivery work remains independently documented and can be resumed without changing this Pixel branch.
