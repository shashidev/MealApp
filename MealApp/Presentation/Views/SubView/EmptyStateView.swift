//
//  EmptyStateView.swift
//  MealApp
//

import SwiftUI

struct EmptyStateView: View {
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}
