//
//  NotificationsView.swift
//  EatXtra
//
//  Created by Subham Patel on 24/01/25.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack{
            Notifications()
                .padding(.top, 50)
            SubButton()
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Notifications: View {
    var body: some View {
        Text("Notifications")
            .font(.headline)
            .fontWeight(.bold)
    }
}

struct SubButton: View {
    @State var selectedTab: String = "All"
    var body: some View {
        HStack(spacing: 10){
            MessageButtons(title: "All", selectedTab: $selectedTab)
            MessageButtons(title: "Read", selectedTab: $selectedTab)
            MessageButtons(title: "Unread", selectedTab: $selectedTab)
        }
        .padding(10)
    }
}

struct MessageButtons: View {
    var title: String
    @Binding var selectedTab: String
    
    var isSelected: Bool {
        selectedTab == title
    }
    var body: some View {
        Button(action: {
            selectedTab = title
        }, label: {
            Text(title)
                .frame(width: 100, height: 40)
                .background(isSelected ? Color.green : Color.white.opacity(0.1))
                .foregroundColor(isSelected ? Color.white : Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.1))
                )
                .cornerRadius(8)
        })
    }
}
#Preview {
    NotificationsView()
}
