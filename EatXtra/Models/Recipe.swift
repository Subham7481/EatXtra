//
//  Recipe.swift
//  EatXtra
//
//  Created by Subham Patel on 14/06/25.
//
import Foundation
struct RecipeSearchResponse: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String?
}

struct RecipeDetailModel: Codable {
    let id: Int
    let title: String
    let image: String?
    let instructions: String?
    let extendedIngredients: [Ingredient]
    let readyInMinutes: Int
}

struct Ingredient: Codable {
    let original: String
}

struct Suggestion: Codable {
    let title: String
}


