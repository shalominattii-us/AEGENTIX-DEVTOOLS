import AppIntents

@available(iOS 17.0, *)
public struct AegentixHeartbeatIntent: AppIntent {
    public static let title: LocalizedStringResource = "AEGENTIX Heartbeat"
    public static let supportedModes: IntentModes = [.background, .foreground(.dynamic)]

    public init() {}

    public func perform() async throws -> some IntentResult {
        // Wire the configured host instance here in the containing iOS app.
        return .result()
    }
}
