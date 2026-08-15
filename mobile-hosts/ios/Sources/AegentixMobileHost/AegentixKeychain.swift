import Foundation
import Security
import CryptoKit

public enum AegentixKeychain {
    private static let service = "us.shalominattii.aegentix.mobile"
    private static let account = "node-signing-key"

    public static func signingKey() throws -> Curve25519.Signing.PrivateKey {
        if let data = try read() { return try Curve25519.Signing.PrivateKey(rawRepresentation: data) }
        let key = Curve25519.Signing.PrivateKey()
        try write(key.rawRepresentation)
        return key
    }

    private static func read() throws -> Data? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess, let data = result as? Data else { throw NSError(domain: NSOSStatusErrorDomain, code: Int(status)) }
        return data
    }

    private static func write(_ data: Data) throws {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: data,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess || status == errSecDuplicateItem else { throw NSError(domain: NSOSStatusErrorDomain, code: Int(status)) }
    }
}
