//
//  ReciepeDetailView.swift
//  RecipeApp
//
//  Created by shubh on 14/10/26.
//
import SwiftUI

struct RecipeDetailView: View {
  let recipe: RecipeModel
  
  @Environment(\.managedObjectContext) private var context
  @State private var isFavorite = false
  @State private var errorMessage: String?
  
  private var repository: FavoritesRepository {
    FavoritesRepository(context: context)
  }
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        RecipeImageView(urlString: recipe.image)
          .frame(maxWidth: .infinity)
          .frame(height: 250)
          .clipShape(RoundedRectangle(cornerRadius: 12))
        
        Text(recipe.name).font(.title.bold())
        
        Text("\(recipe.cuisine) · \(recipe.mealType.joined(separator: ", "))")
          .foregroundStyle(.secondary)
        
        Label("\(recipe.cookTimeMinutes) min cook time", systemImage: "clock")
        
        Button {
          addToFavorites()
        } label: {
          Label(isFavorite ? "Already in Favourites" : "Add to Favourites",
                systemImage: isFavorite ? "heart.fill" : "heart")
          .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .disabled(isFavorite)
        
        Text("Ingredients").font(.headline)
        ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { _, item in
          Text("• \(item)")
        }
        
        Text("Instructions").font(.headline)
        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, step in
          Text("\(index + 1). \(step)")
        }
      }
      .padding()
    }
    .navigationTitle("Details")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear { isFavorite = repository.isFavorite(id: recipe.id) }
    .alert("Couldn't save", isPresented: Binding(
      get: { errorMessage != nil },
      set: { if !$0 { errorMessage = nil } }
    )) {
      Button("OK", role: .cancel) {}
    } message: {
      Text(errorMessage ?? "")
    }
  }
  
  private func addToFavorites() {
    do {
      try repository.add(recipe)
      isFavorite = true
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
