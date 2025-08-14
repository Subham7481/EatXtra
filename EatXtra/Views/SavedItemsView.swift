//
//  SavedItemsView.swift
//  EatXtra
//
//  Created by Subham Patel on 24/01/25.
//

import SwiftUI

struct SavedItemsView: View {
    var body: some View {
        VStack{
            MessageView()
                .padding(.top, 50)
            DetailView()
            Spacer()
        }
    }
}

struct MessageView: View {
    var body: some View{
        Text("Saved Recipes")
            .font(.headline)
            .fontWeight(.bold)
        
        
    }
}

struct DetailView: View {
    @EnvironmentObject var viewModel : SavedRecipeViewModel
    var body: some View {
        List(viewModel.savedRecipies){ recipe in
            HStack {
                 Image(recipe.image)
                     .resizable()
                     .frame(width: 60, height: 60)
                     .clipShape(RoundedRectangle(cornerRadius: 10))
                
                 Spacer()
                
                 VStack(alignment: .trailing) {
                     Text(recipe.name)
                         .font(.headline)
                     Text(recipe.time)
                         .font(.subheadline)
                         .foregroundColor(.gray)
                 }
            }
        }
    }
}

#Preview {
    SavedItemsView()
}
