//
//  NewRecipiesDetailView.swift
//  EatXtra
//
//  Created by Subham Patel on 14/08/25.
//

import SwiftUI

struct NewRecipiesDetailView: View {
    let recipeName: String
    let imageName: String
    var body: some View {
        VStack(spacing: 20) {
                    Text("This recipe is coming very soon...")
                        .font(.headline)
                    
                    Text(recipeName)
                        .font(.largeTitle)
                        .bold()
                    
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    
                    Text("Enjoy cooking your delicious \(recipeName)! 🍽")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                }
                .padding()
    }
}

#Preview {
    NewRecipiesDetailView(recipeName: "", imageName: "")
}
