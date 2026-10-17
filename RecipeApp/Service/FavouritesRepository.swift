//
//  FavouritesRepository.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.
//

import Foundation
import CoreData

// All Core Data work for favorites lives here, so views stay simple.
struct FavoritesRepository {
  let context: NSManagedObjectContext
  
  // Duplicate check: asks Core Data whether this id is already saved.
  func isFavorite(id: Int) -> Bool {
    let request = FavoriteRecipe.fetchRequest()
    request.predicate = NSPredicate(format: "id == %lld", Int64(id))
    request.fetchLimit = 1
    return ((try? context.count(for: request)) ?? 0) > 0
  }
  
  // Returns false (and saves nothing) if the recipe is already a favorite.
  @discardableResult
  func add(_ recipe: RecipeModel) throws -> Bool {
    guard !isFavorite(id: recipe.id) else { return false }
    
    let favorite = FavoriteRecipe(context: context)
    favorite.id = Int64(recipe.id)
    favorite.name = recipe.name
    favorite.cuisine = recipe.cuisine
    favorite.image = recipe.image
    favorite.cookTimeMinutes = Int32(recipe.cookTimeMinutes)
    favorite.ingredients = recipe.ingredients.joined(separator: "\n")
    
    do {
      try context.save()
      return true
    } catch {
      context.rollback()
      throw error
    }
  }
  
  func delete(_ favorite: FavoriteRecipe) throws {
    context.delete(favorite)
    do {
      try context.save()
    } catch {
      context.rollback()
      throw error
    }
  }
}
