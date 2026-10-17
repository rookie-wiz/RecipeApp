//
//  FavouritesView.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.
//
import SwiftUI
import CoreData

struct FavouritesView: View {
  @Environment(\.managedObjectContext) private var context
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteRecipe.name, ascending: true)]
  )
  private var favorites: FetchedResults<FavoriteRecipe>
  
  @State private var errorMessage: String?
  
  var body: some View {
    Group {
      if favorites.isEmpty {
        ContentUnavailableView(
          "No Favorites Yet",
          systemImage: "heart",
          description: Text("Recipes you favorite will show up here.")
        )
      } else {
        List {
          ForEach(favorites, id: \.objectID) { favorite in
            HStack(spacing: 12) {
              RecipeImageView(urlString: favorite.image ?? "")
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
              
              VStack(alignment: .leading, spacing: 4) {
                Text(favorite.name ?? "Unknown").font(.headline)
                Text("\(favorite.cuisine ?? "") · \(favorite.cookTimeMinutes) min")
                  .font(.subheadline)
                  .foregroundStyle(.secondary)
              }
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
              Button(role: .destructive) {
                delete(favorite)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
          }
        }
      }
    }
    .navigationTitle("Favorites")
    .alert("Couldn't delete", isPresented: Binding(
      get: { errorMessage != nil },
      set: { if !$0 { errorMessage = nil } }
    )) {
      Button("OK", role: .cancel) {}
    } message: {
      Text(errorMessage ?? "")
    }
  }
  
  private func delete(_ favorite: FavoriteRecipe) {
    do {
      try FavoritesRepository(context: context).delete(favorite)
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
