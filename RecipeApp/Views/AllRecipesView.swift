//
//  AllReciepesView.swift
//  RecipeApp
//
//  Created by shubh on 14/10/26.
//
import SwiftUI

struct AllRecipesView: View {
  @StateObject private var viewModel = RecipesViewModel()

  var body: some View {
    Group {
      switch viewModel.state {
      case .idle, .loading:
        ProgressView("Loading recipes…")

      case .failed(let message):
        ContentUnavailableView {
          Label("Couldn't load recipes", systemImage: "wifi.slash")
        } description: {
          Text(message)
        } actions: {
          Button("Retry") { Task { await viewModel.load() } }
        }

      case .loaded(let recipes):
        List(recipes) { recipe in
          // Destination-style link: the row itself says which screen to open,
          // so no .navigationDestination is needed anywhere in the project.
          NavigationLink {
            RecipeDetailView(recipe: recipe)
          } label: {
            HStack(spacing: 12) {
              RecipeImageView(urlString: recipe.image)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))

              VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name).font(.headline)
                Text("\(recipe.cuisine) · \(recipe.cookTimeMinutes) min")
                  .font(.subheadline)
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
      }
    }
    .navigationTitle("All Recipes")
    .task { await viewModel.load() }
  }
}
