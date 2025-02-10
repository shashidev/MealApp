//
//  HomeViewSnapshotTest.swift
//  MealAppTests
//


import XCTest
import SnapshotTesting
import SwiftUI
@testable import MealApp

final class HomeViewSnapshotTest: XCTestCase {
    
    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        // Add any initial setup required before each test.
        // This is executed before each test method is invoked.
    }
    
    // MARK: - Test Cases
    
    /// Snapshot test for HomeView with meals data.
    func testHomeViewWithMeals() {
        
        let categories = [
            Categories(idCategory: "1", strCategory: "All"),
            Categories(idCategory: "2", strCategory: "Chicken"),
            Categories(idCategory: "3", strCategory: "Lamb"),
            Categories(idCategory: "4", strCategory: "Sides"),
            Categories(idCategory: "5", strCategory: "Dessert")
        ]
        
        let meals = [
            Meals(idMeal: "1", strMeal: "Pasta", strMealThumb: "img-pasta"),
            Meals(idMeal: "2", strMeal: "Chicken Handi", strMealThumb: "img-chicken-handi"),
            Meals(idMeal: "3", strMeal: "Chicken Karaage", strMealThumb: "img-chicken-karaage"),
            Meals(idMeal: "4", strMeal: "Lamb Tagine", strMealThumb: "img-lamb-tagine"),
            Meals(idMeal: "5", strMeal: "chicken-ongee", strMealThumb: "img-chicken-ongee")
        ]
        
        let mockViewModel = createMockViewModel(categories: categories, meals: meals)
        
        // Run snapshot test for HomeView with meals
        runSnapshotTest(for: HomeView(viewModel: mockViewModel), testName: "HomeViewWithMeals")
    }
    
    /// Snapshot test for HomeView without meals data.
    func testHomeViewWithoutMeals() {
        
        let categories = [
            Categories(idCategory: "1", strCategory: "All"),
            Categories(idCategory: "2", strCategory: "Chicken"),
            Categories(idCategory: "3", strCategory: "Lamb"),
            Categories(idCategory: "4", strCategory: "Sides"),
            Categories(idCategory: "5", strCategory: "Dessert")
        ]
        let meals:[Meals] = []
        
        let mockViewModel = createMockViewModel(categories: categories, meals: meals)
        
        // Run snapshot test for HomeView without meals
        runSnapshotTest(for: HomeView(viewModel: mockViewModel), testName: "HomeViewWithoutMeals")
    }
    
    // MARK: - Helper Methods
    
    /// Creates a mock `HomeViewModel` with the provided categories and meals.
    /// - Parameters:
    ///   - categories: A list of `Categories` to populate the view model.
    ///   - meals: A list of `Meals` to populate the view model.
    /// - Returns: A `HomeViewModel` object initialized with the given data.
    private func createMockViewModel(categories: [Categories], meals: [Meals]) -> HomeViewModel {
        let viewModel = HomeViewModel()
        viewModel.categories = categories
        viewModel.meals = meals
        return viewModel
    }
    
    /// Runs a snapshot test for the given SwiftUI view.
    /// - Parameters:
    ///   - view: The SwiftUI view to be tested.
    ///   - testName: A descriptive name for the snapshot test.
    private func runSnapshotTest(for view: some View, testName: String) {
        // Wrap the view in a UIHostingController for snapshot testing
        let hostingController = UIHostingController(rootView: view)
        // Run the snapshot test and compare it to the reference image
        assertSnapshot(of: hostingController, as: .image, named: testName)
    }
}


