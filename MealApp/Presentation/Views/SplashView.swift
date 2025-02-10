//
//  SplashView.swift
//  MealApp
//

import SwiftUI

struct SplashView: View {
    @State private var showMainView = false
    private let homeViewModel = HomeViewModel()
    
    var body: some View {
        // Show either the SplashScreen or MainView based on showMainView state
        if showMainView {
            HomeView(viewModel: homeViewModel) // Navigate to HomePage after the splash screen
        } else {
            VStack {
                Text("Meal App!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text("Ready to cook up something amazing?")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
}

#Preview {
    SplashView()
}
