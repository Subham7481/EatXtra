import SwiftUI

struct SearchRecipeView: View {
    @StateObject var viewModel = SearchViewViewModel()
    @State private var query: String = ""
    @State private var results: [Recipe] = []
    @State private var isLoading = false
    @State private var selectedRecipe: RecipeDetails? = nil
    var body: some View {
        VStack{
            SearchView(query: $query, isLoading: $isLoading, results: $results, viewModel: viewModel)
        }
    }
}

struct SearchView: View {
    @Binding var query: String
    @Binding var isLoading: Bool
    @Binding var results: [Recipe]
    @ObservedObject var viewModel: SearchViewViewModel
    
    var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 10){
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.black.opacity(0.3))
                            .font(.system(size: 27))
                            .padding(.leading, 10)
                        
                        TextField("Search recipe", text: $query, onCommit: {
                            performSearch()
                        })
                        .font(.callout)
                        .foregroundColor(Color.black.opacity(0.8))
                        .padding(.leading, 5)
                        
                        Spacer()
                        
                    }
                    .frame(height: 60)
                    .padding(.horizontal, 10) // Inner padding
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        // Add filter action here
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .padding(10)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(20)
                // Results List
                if isLoading {
                    ProgressView("Searching...")
                        .padding()
                } else {
                    List(results, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetails(recipeID: recipe.id)) {
                            HStack {
                                if let imageURL = URL(string: recipe.image ?? "") {
                                    AsyncImage(url: imageURL) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(6)
                                }
                                
                                Text(recipe.title)
                            }
                        }
                    }
                }
                Spacer()
            .navigationTitle("Search Recipe")
        }
    }
    
    private func performSearch() {
        isLoading = true
        viewModel.searchRecipes(query: query) { fetchedRecipes in
            self.results = fetchedRecipes
            self.isLoading = false
        }
    }
}


#Preview {
    SearchRecipeView()
}
