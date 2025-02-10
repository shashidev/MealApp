//
//  LoadingView.swift
//  MealApp
//


import SwiftUI

struct LoadingView: View {
    let message: String
    var body: some View {
        ProgressView(message)
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
