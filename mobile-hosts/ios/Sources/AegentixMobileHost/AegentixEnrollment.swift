import Foundation
import CryptoKit

public struct AegentixNodeIdentity: Codable, Sendable {
    public let nodeId: String
    public let platform: String
    public let publicKey: String
    public let createdAt: Date
}

public final class AegentixEnrollment: @unchecked Sendable {
    private let defaults: UserDefaults
    private let key = "aegentix.node.identity"

    public init(defaults: UserDefaults = .standard) { self.defaults = defaults }

    public func identity() throws -> AegentixNodeIdentity {
        if let data = defaults.data(forKey: key), let identity = try? JSONDecoder().decode(AegentixNodeIdentity.self, from: data) { return identity }
        let privateKey = Curve25519.Signing.PrivateKey()
        let identity = AegentixNodeIdentity(
            nodeId: "aegentix-ios-\(UUID().uuidString.lowercased())",
            platform: "ios",
            publicKey: privateKey.publicKey.rawRepresentation.base64EncodedString(),
            createdAt: Date()
        )
        defaults.set(try JSONEncoder().encode(identity), forKey: key)
        return identity
    }
}
