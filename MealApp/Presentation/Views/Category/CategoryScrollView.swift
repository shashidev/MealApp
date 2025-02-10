//
//  CategoryScrollView.swift
//  MealApp
//

import SwiftUI

struct CategoryScrollView<ViewModel: HomeViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.categories) { category in
                        CategoryItemView(category: category, selectedCategory: $viewModel.defaultCategory)
                            .onTapGesture {
                                handleCategorySelection(for: category)
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
    }
    
    private func handleCategorySelection(for category: Categories) {
        viewModel.defaultCategory = category.strCategory ?? ""
        viewModel.loadMeal(category: category.strCategory ?? "")
    }
}

