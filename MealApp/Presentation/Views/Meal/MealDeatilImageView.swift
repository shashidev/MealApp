//
//  MealImageView.swift
//  MealApp
//

import SwiftUI

struct MealDeatilImageView: View {
    let imageURL: String?

    var body: some View {
        let placeholderImage = UIImage(named: "img-placeholder")!
        
        Group {
            if let urlString = imageURL, let url = URL(string: urlString), url.scheme?.hasPrefix("http") == true {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(uiImage: UIImage(named: imageURL ?? "img-placeholder") ?? placeholderImage)
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(height: 250)
        .clipped()
        .cornerRadius(10)
        .padding(.horizontal)
    }

}
