//
//  SearchViewViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 14/06/25.
//

import Foundation
class SearchViewViewModel: ObservableObject{
    let apiKey = "0a2ac72082a04146b1cfc98c2f940556"
    
    func searchRecipes(query: String, completion: @escaping ([Recipe]) -> Void) {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([])
            return
        }
        
        let urlString = "https://api.spoonacular.com/recipes/complexSearch?query=\(queryEncoded)&number=10&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ API error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("❌ No data")
                completion([])
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("❌ Decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
    
    // MARK: - 2. Fetch Recipe Details by ID
    func fetchRecipeDetails(recipeID: Int, completion: @escaping (RecipeDetailModel?) -> Void) {
        let urlString = "https://api.spoonacular.com/recipes/\(recipeID)/information?apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ API error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("❌ No data")
                completion(nil)
                return
            }
            
            do {
                let details = try JSONDecoder().decode(RecipeDetailModel.self, from: data)
                DispatchQueue.main.async {
                    completion(details)
                }
            } catch {
                print("❌ Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - 3. Autocomplete Suggestions (Optional)
    func fetchSuggestions(query: String, completion: @escaping ([String]) -> Void) {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion([])
            return
        }
        
        let urlString = "https://api.spoonacular.com/recipes/autocomplete?query=\(queryEncoded)&number=5&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("❌ Invalid suggestion URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ Suggestion API error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("❌ No suggestion data")
                completion([])
                return
            }
            
            do {
                let suggestions = try JSONDecoder().decode([Suggestion].self, from: data)
                let suggestionTitles = suggestions.map { $0.title }
                DispatchQueue.main.async {
                    completion(suggestionTitles)
                }
            } catch {
                print("❌ Suggestion decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
}
