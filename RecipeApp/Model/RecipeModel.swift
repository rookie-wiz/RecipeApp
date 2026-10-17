//
//  RecipeModel.swift
//  MyApp
//
//  Created by shubh on 14/10/26.
//

import Foundation

// API docs: https://dummyjson.com/docs/recipes
// One recipe from the API (temporary, in-memory data).

struct RecipeModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}

// The list endpoint wraps the array: {"recipes": [...], "total": ..., ...}

struct RecipesResponse: Codable {
    let recipes: [RecipeModel]
    let total: Int
    let skip: Int
    let limit: Int
}
