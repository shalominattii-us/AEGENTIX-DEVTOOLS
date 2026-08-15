import Foundation
import AVFoundation
import CoreLocation
import CoreMotion
import LocalAuthentication
import Network
import Photos
import UIKit

public enum AegentixCapabilityStatus: String, Codable, Sendable { case available, permissionRequired, unavailable, restricted }
public struct AegentixCapability: Codable, Sendable { public let id: String; public let status: AegentixCapabilityStatus; public let detail: String }

public struct AegentixDeviceCapabilities: Sendable {
    public static func snapshot() -> [AegentixCapability] {
        [
            .init(id: "camera", status: AVCaptureDevice.default(for: .video) == nil ? .unavailable : .available, detail: "AVFoundation camera availability"),
            .init(id: "microphone", status: AVCaptureDevice.default(for: .audio) == nil ? .unavailable : .available, detail: "AVFoundation microphone availability"),
            .init(id: "location", status: CLLocationManager.locationServicesEnabled() ? .permissionRequired : .restricted, detail: "Location services state"),
            .init(id: "motion", status: CMMotionManager().isDeviceMotionAvailable ? .available : .unavailable, detail: "Core Motion availability"),
            .init(id: "biometrics", status: .available, detail: "LocalAuthentication capability queried at authorization time"),
            .init(id: "network", status: .available, detail: "Network.framework available"),
            .init(id: "photos", status: .permissionRequired, detail: "Photo Library authorization queried by feature"),
            .init(id: "ui", status: .available, detail: "Native application UI available"),
            .init(id: "notifications", status: .permissionRequired, detail: "UserNotifications authorization required")
        ]
    }
}
