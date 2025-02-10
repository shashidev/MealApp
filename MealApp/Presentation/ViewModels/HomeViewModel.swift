//
//  ItemListViewModel.swift
//  MealApp
//

import Combine
import Foundation

/// The view model responsible for managing the state related to categories and meals
/// and handling data fetching and transformation for the home screen.
final class HomeViewModel: HomeViewModelProtocol {
    
    @Published var categories: [Categories] = []
    @Published var meals: [Meals] = []
    @Published var defaultCategory: String?
    @Published var isloading: Bool = false
    @Published var isConnected: Bool = true
    
    // A dictionary to cache meals for each category, reducing redundant API calls by storing previously fetched data.
    private var mealsCache: [String: [Meals]] = [:]
    
    /// A set to hold cancellables for the Combine framework to manage memory.
    private var cancellables = Set<AnyCancellable>()
    
    /// The service facade used to fetch categories and meals.
    private let mealServiceFacade: MealServiceFacade

    /// Initializes the `HomeViewModel` with a provided or default `MealServiceFacade`.
    /// - Parameter mealServiceFacade: The service facade used to fetch categories and meals (default is `MealServiceFacade`).
    init(mealServiceFacade: MealServiceFacade = MealServiceFacade()) {
        self.mealServiceFacade = mealServiceFacade
        self.observeNetworkReachability()
    }
    
    
    /// Observes the network reachability status and updates the local `isConnected` property
    /// based on the current network connection status.
     func observeNetworkReachability() {
        ReachabilityUtility.shared.$isReachable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isConnected in
                self?.isConnected = isConnected
            }
            .store(in: &cancellables)
    }


    /// Loads categories by calling the corresponding service method and handles the result.
    func loadCategories() {
        mealServiceFacade.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugLog("Error loading items: \(error)")
                }
            }, receiveValue: { [weak self] categories in
                self?.setupCategories(with: categories)
            })
            .store(in: &cancellables)
    }

    /// Loads meals for a specific category by calling the corresponding service method and handles the result.
    /// - Parameter category: The category for which meals should be fetched.
    func loadMeal(category: String) {
        // Check the cache first
        if let cachedMeals = mealsCache[category] {
            self.meals = cachedMeals
            return
        }
        self.isloading = true
        mealServiceFacade.fetchMeals(for: category)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.isloading = false
                    debugLog("Error loading meals: \(error)")
                    self?.meals = []
                }
            }, receiveValue: { [weak self] meals in
                self?.isloading = false
                self?.meals = meals
                self?.mealsCache[category] = meals
            })
            .store(in: &cancellables)
    }

    /// Loads all meals by calling the corresponding service method and handles the result.
    func loadAllMeals() {
        // Check the cache first
        if let cachedMeals = mealsCache["All"] {
            self.meals = cachedMeals
            return
        }
        self.isloading = true
        
        mealServiceFacade.fetchAllMeals()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.isloading = false
                    debugLog("Error loading all meals: \(error)")
                    self?.meals = []
                }
            }, receiveValue: { [weak self] meals in
                self?.isloading = false
                self?.meals = meals
                self?.mealsCache["All"] = meals
            })
            .store(in: &cancellables)
    }

    /// Sets up categories, adding the "All" category to the list and assigning the default category.
    /// - Parameter categories: The list of categories to be transformed and displayed.
    private func setupCategories(with categories: [Categories]) {
        let allCategory = Categories(strCategory: "All")
        var allCategories = [allCategory]
        allCategories.append(contentsOf: categories)
        self.categories = allCategories
        self.defaultCategory = "All"
        loadAllMeals()
    }
}


