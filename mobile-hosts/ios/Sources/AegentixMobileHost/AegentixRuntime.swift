import Foundation
import Network

public actor AegentixRuntime {
    public let host: AegentixHost
    public let identity: AegentixNodeIdentity
    public let queue: AegentixOfflineQueue
    private let monitor = NWPathMonitor()
    private var connected = false

    public init(endpoint: URL) throws {
        let enrollment = AegentixEnrollment()
        self.identity = try enrollment.identity()
        self.host = try AegentixHost(nodeId: identity.nodeId, endpoint: endpoint)
        self.queue = AegentixOfflineQueue(journal: try AegentixJournal())
    }

    public func start() async {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { await self?.pathChanged(path.status == .satisfied) }
        }
        monitor.start(queue: DispatchQueue(label: "aegentix.network.monitor"))
        await heartbeat()
    }

    private func pathChanged(_ online: Bool) async {
        connected = online
        if online {
            await queue.drain { [host] event in
                try await host.send(event)
            }
            await heartbeat()
        }
    }

    private func heartbeat() async {
        guard connected else { return }
        do {
            _ = try await host.emit(type: "heartbeat", policy: "preapproved", payload: ["node_id": identity.nodeId, "status": "online"])
        } catch { /* queued by higher-level command path */ }
    }
}
