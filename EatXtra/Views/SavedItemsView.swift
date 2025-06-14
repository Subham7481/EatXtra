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

#Preview {
    SavedItemsView()
}
