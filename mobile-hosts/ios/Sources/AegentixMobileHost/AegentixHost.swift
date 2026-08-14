import Foundation
import CryptoKit

public struct AegentixEnvelope: Codable, Sendable {
    public let eventId: UUID
    public let nodeId: String
    public let type: String
    public let timestamp: Date
    public let causalParent: UUID?
    public let payloadHash: String
    public let policy: String
    public let payload: [String: String]

    public init(nodeId: String, type: String, causalParent: UUID? = nil, policy: String, payload: [String: String]) throws {
        self.eventId = UUID()
        self.nodeId = nodeId
        self.type = type
        self.timestamp = Date()
        self.causalParent = causalParent
        self.policy = policy
        self.payload = payload
        let data = try JSONEncoder().encode(payload)
        self.payloadHash = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
}

public actor AegentixJournal {
    private let url: URL
    private let encoder = JSONEncoder()

    public init(filename: String = "aegentix-events.jsonl") throws {
        let base = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        self.url = base.appendingPathComponent(filename)
        encoder.dateEncodingStrategy = .iso8601
    }

    public func append(_ envelope: AegentixEnvelope) throws {
        let data = try encoder.encode(envelope)
        let line = data + Data([0x0a])
        if !FileManager.default.fileExists(atPath: url.path) { FileManager.default.createFile(atPath: url.path, contents: nil) }
        let handle = try FileHandle(forWritingTo: url)
        defer { try? handle.close() }
        try handle.seekToEnd()
        try handle.write(contentsOf: line)
    }
}

public actor AegentixHost {
    public let nodeId: String
    private let endpoint: URL
    private let journal: AegentixJournal
    private let session: URLSession

    public init(nodeId: String, endpoint: URL) throws {
        self.nodeId = nodeId
        self.endpoint = endpoint
        self.journal = try AegentixJournal()
        self.session = .shared
    }

    public func emit(type: String, policy: String = "guardian-required", payload: [String: String]) async throws -> AegentixEnvelope {
        let event = try AegentixEnvelope(nodeId: nodeId, type: type, policy: policy, payload: payload)
        try await journal.append(event) // event first
        var request = URLRequest(url: endpoint.appendingPathComponent("events"))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(event)
        _ = try await session.data(for: request)
        return event
    }
}
