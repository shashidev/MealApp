//
//  MockReachabilityUtility.swift
//  MealAppTests
//


import XCTest
import Combine

// Mock class to simulate reachability status changes
final class MockReachabilityUtility {
    // Property to hold the current reachability status
    var isReachable: Bool
    
    // Subject to provide updates about reachability changes
    private var subject = CurrentValueSubject<Bool, Never>(true)
    
    // Initializer to set the initial reachability state
    init(isReachable: Bool) {
        self.isReachable = isReachable
    }
    
    // Method to simulate a change in reachability status
    func simulateReachabilityChange() {
        // Toggle the current reachability status
        isReachable.toggle()
        // Notify observers about the updated status
        subject.send(isReachable)
    }
    
    // Provide a publisher for reachability status updates
    var reachabilityPublisher: AnyPublisher<Bool, Never> {
        return subject.eraseToAnyPublisher()
    }
}

