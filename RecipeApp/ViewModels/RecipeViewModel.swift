//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by shubh on 16/10/26.
//

import Foundation
import Combine

@MainActor
final class RecipesViewModel: ObservableObject {
  
  enum State {
    case idle
    case loading
    case loaded([RecipeModel])
    case failed(String)
  }
  
  @Published private(set) var state: State = .idle
  
  private let service: RecipeAPIService
  
  init(service: RecipeAPIService = RecipeAPIService()) {
    self.service = service
  }
  
  func load() async {
    switch state {
    case .loading, .loaded: return   // don't reload needlessly
    default: break
    }
    
    state = .loading
    do {
      let recipes = try await service.fetchRecipes()
      state = .loaded(recipes)
    } catch {
      state = .failed(error.localizedDescription)
    }
  }
}
