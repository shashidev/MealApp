//
//  NoInternetView.swift
//  MealApp
//

import SwiftUI

struct NoInternetView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.gray)
            .padding()
    }
}
