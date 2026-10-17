//
//  RecipeApiService.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.
//

import Foundation

enum RecipeAPIError: LocalizedError {
  case invalidURL
  case badResponse(statusCode: Int)
  case decodingFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "The recipe URL is invalid."
    case .badResponse(let code):
      return "The server returned an error (\(code))."
    case .decodingFailed:
      return "We couldn't read the recipe data."
    }
  }
}

struct RecipeAPIService {
  private let urlString = "https://dummyjson.com/recipes"
  
  func fetchRecipes() async throws -> [RecipeModel] {
    guard let url = URL(string: urlString) else {
      throw RecipeAPIError.invalidURL
    }
    
    // Network failures (offline, timeout) are thrown by URLSession itself
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let http = response as? HTTPURLResponse,
          (200...299).contains(http.statusCode) else {
      let code = (response as? HTTPURLResponse)?.statusCode ?? -1
      throw RecipeAPIError.badResponse(statusCode: code)
    }
    
    do {
      return try JSONDecoder().decode(RecipesResponse.self, from: data).recipes
    } catch {
      throw RecipeAPIError.decodingFailed
    }
  }
}
