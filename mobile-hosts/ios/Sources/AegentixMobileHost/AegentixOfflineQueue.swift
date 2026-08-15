import Foundation

public actor AegentixOfflineQueue {
    private var pending: [AegentixEnvelope] = []
    private let journal: AegentixJournal

    public init(journal: AegentixJournal) { self.journal = journal }

    public func enqueue(_ event: AegentixEnvelope) async throws {
        pending.append(event)
        try await journal.append(event)
    }

    public func drain(using sender: @Sendable (AegentixEnvelope) async throws -> Void) async {
        var remaining: [AegentixEnvelope] = []
        for event in pending {
            do { try await sender(event) } catch { remaining.append(event) }
        }
        pending = remaining
    }

    public func count() -> Int { pending.count }
}
