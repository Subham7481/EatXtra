//
//  SavedRecipeViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 14/08/25.
//

import Foundation
class SavedRecipeViewModel: ObservableObject{
    @Published var savedRecipies: [SaveRecipe] = []
    
    func save(_ dish: SaveRecipe) {
        if !savedRecipies.contains(where: { $0.id == dish.id }) {
            savedRecipies.append(dish)
        }
    }
}
