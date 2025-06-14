import SwiftUI

struct RecipeDetails: View {
    let recipeID: Int
    @State private var recipeDetail: RecipeDetailModel?
    @StateObject private var viewModel = SearchViewViewModel()

    var body: some View {
        ScrollView {
            if let detail = recipeDetail {
                VStack(alignment: .leading, spacing: 20) {
                    if let imageURL = URL(string: detail.image ?? "") {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray
                        }
                    }

                    Text(detail.title)
                        .font(.title)

                    Text("Ready in \(detail.readyInMinutes) minutes")
                        .font(.subheadline)

                    if !detail.extendedIngredients.isEmpty {
                        Text("Ingredients:")
                            .font(.headline)
                        ForEach(detail.extendedIngredients, id: \.original) { ingredient in
                            Text("• \(ingredient.original)")
                                .font(.body)
                        }
                    }

                    if let instructions = detail.instructions {
                        Text("Instructions:")
                            .font(.headline)
                        Text(instructions)
                            .font(.body)
                    }
                }
                .padding()
            } else {
                ProgressView("Loading details...")
            }
        }
        .onAppear {
            viewModel.fetchRecipeDetails(recipeID: recipeID) { detail in
                self.recipeDetail = detail
            }
        }
        .navigationTitle("Recipe Details")
    }
}


#Preview {
    RecipeDetails(recipeID: 1)
        .environmentObject(SearchViewViewModel())
}

