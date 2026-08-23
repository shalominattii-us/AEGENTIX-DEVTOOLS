import AppIntents

@available(iOS 17.0, *)
public struct AegentixHeartbeatIntent: AppIntent {
    public static let title: LocalizedStringResource = "AEGENTIX Heartbeat"

    public init() {}

    public func perform() async throws -> some IntentResult {
        // The containing iOS app wires the configured host instance.
        return .result()
    }
}
