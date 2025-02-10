//
//  HomeViewModelProtocol.swift
//  MealApp
//

import Foundation

/// Protocol defining the contract for the Home ViewModel.
/// The HomeViewModelProtocol is responsible for exposing necessary data and actions to the View layer
/// (i.e., the UI). It defines properties like categories, meals, loading state, and connectivity status,
/// along with methods to load data, observe network status, and manage meal data.
protocol HomeViewModelProtocol: ObservableObject {
    
    /// The list of categories to be displayed in the UI.
    /// This property holds the categories fetched from the domain layer.
    /// It should be updated whenever categories are successfully loaded.
    var categories: [Categories] { get set }
    
    /// The list of meals to be displayed in the UI.
    /// This property holds the meals associated with a category, fetched from the domain layer.
    /// It should be updated when meals for a specific category are loaded.
    var meals: [Meals] { get set }
    
    /// The default selected category.
    /// This property holds the identifier of the default category selected by the user
    /// or the default selection when the app first loads.
    var defaultCategory: String? { get set }
    
    /// Tracks the loading state of the data.
    /// This property is used to show or hide loading indicators in the UI,
    /// helping to inform the user when data is being fetched.
    var isloading: Bool { get set }
    
    /// Tracks the network connection status.
    /// This property is updated based on the network reachability and is used
    /// to inform the user if they have internet access.
    var isConnected: Bool { get set }

    /// Observes the network reachability status.
    /// This method listens for changes in network connectivity (such as WiFi or cellular)
    /// and updates the `isConnected` property accordingly.
    /// This method should be called once when the ViewModel is initialized to start observing network status.
    func observeNetworkReachability()
    
    /// Loads categories by calling the corresponding service method and handles the result.
    /// This method is responsible for invoking the appropriate service to fetch categories
    /// from the network and then updating the `categories` property once the data is successfully fetched.
    func loadCategories()
    
    /// Loads meals for a specific category.
    /// - Parameter category: The category for which meals should be fetched.
    /// This method fetches meals associated with the provided category from the service layer.
    /// Once the meals are fetched, it updates the `meals` property.
    func loadMeal(category: String)
    
    /// Loads all meals and caches the result.
    /// This method fetches all meals (not associated with a category) and updates the `meals` property.
    /// It also caches the fetched data to avoid redundant API calls for the same data.
    func loadAllMeals()
}

