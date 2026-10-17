//
//  HomeView.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.

import SwiftUI

struct HomeView: View {
  var body: some View {
    NavigationStack {
      List {
        NavigationLink {
          AllRecipesView()
        } label: {
          Label("View All Recipes", systemImage: "book")
        }

        NavigationLink {
          FavouritesView()
        } label: {
          Label("View Favorite Recipes", systemImage: "heart")
        }
      }
      .navigationTitle("Recipes")
      .navigationDestination(for: RecipeModel.self) { recipe in
        RecipeDetailView(recipe: recipe)
      }
    }
  }
}

#Preview {
  HomeView()
}
