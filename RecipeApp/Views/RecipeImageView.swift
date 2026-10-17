//
//  RecipeImageView.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.
//
import SwiftUI

// Reusable remote image with loading and failure states.
struct RecipeImageView: View {
  let urlString: String
  
  var body: some View {
    AsyncImage(url: URL(string: urlString)) { phase in
      switch phase {
      case .success(let image):
        image.resizable().scaledToFill()
      case .failure:
        Image(systemName: "photo")
          .foregroundStyle(.secondary)
      default:
        ProgressView()
      }
    }
  }
}
