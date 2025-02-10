//
//  ReachabilityUtility.swift
//  MealApp
//

import Foundation
import Network

/// A singleton class to monitor the network reachability status.
final class ReachabilityUtility: ObservableObject {
    
    // Singleton instance for shared access
    static let shared = ReachabilityUtility()

    // Network monitor that tracks changes in network path status
    private let monitor = NWPathMonitor()

    // DispatchQueue to perform network monitoring tasks off the main thread
    private let queue = DispatchQueue(label: "ReachabilityMonitor")

    // Published property to reflect network reachability status
    @Published var isReachable: Bool = true

    /// Private initializer to set up the network path monitor.
    private init() {
        // Set the handler to execute when the network path status changes
        monitor.pathUpdateHandler = { [weak self] path in
            // Ensure UI updates happen on the main thread
            DispatchQueue.main.async {
                // Update the reachability status based on the network path
                self?.isReachable = path.status == .satisfied
            }
        }
        // Start monitoring network path status
        monitor.start(queue: queue)
    }

    /// Stops network reachability monitoring.
    func stopMonitoring() {
        monitor.cancel()
    }
}


