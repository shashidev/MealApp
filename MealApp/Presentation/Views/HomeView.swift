//
//  ContentView.swift
//  MealApp
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var hasInitialized = false

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.isConnected {
                    NoInternetView(message: UIConstants.ErrorMessages.noInternetConnection)
                }else {
                    CategoryScrollView(viewModel: viewModel)
                        .onAppear() {
                            guard !hasInitialized else { return }
                            viewModel.loadCategories()
                            hasInitialized = true
                        }
                    if viewModel.isloading {
                        LoadingView(message: UIConstants.LoadingMessages.loadingMeals)
                    } else if !viewModel.meals.isEmpty {
                        MealListView(meals: viewModel.meals)
                    } else {
                        EmptyStateView(message: UIConstants.ErrorMessages.noMealsAvailable)
                    }
                }
            }
            .navigationTitle(UIConstants.NavigationTitles.home)
        }
    }
}


//// Preview
struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
