//
//  ProfileView.swift
//  EatXtra
//
//  Created by Subham Patel on 21/01/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    @State var navigateToLogin = false

    var body: some View {
        ZStack{
            Color.gray.opacity(0.1)
                .ignoresSafeArea(.all)
            VStack {
                ProfileHeader(viewModel: viewModel, navigateToLogin: $navigateToLogin)
                    .padding(.top, 40)
                ProfileStats()
                
                if let user = viewModel.user {
                    ProfileDetails(user: user)
                }
                
                SubButtons()
                Spacer()
                
            }
            .onAppear {
                viewModel.fetchUserData()
            }
        }
    }
}

struct ProfileHeader: View {
    @ObservedObject var viewModel: ProfileViewViewModel
    @Binding var navigateToLogin: Bool
    var body: some View {
        ZStack{
            Text("Profile")
                .font(.headline)
                .fontWeight(.bold)
            
            HStack {
                Spacer()
                ProfileMenu(viewModel: viewModel, navigateToLogin: $navigateToLogin)
            }
        }
//        .padding()
    }
}

struct ProfileMenu: View {
    @ObservedObject var viewModel: ProfileViewViewModel
    @Binding var navigateToLogin: Bool
    var body: some View {
        Menu {
            Button(action: { print("Share Clicked") }) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            Button(action: { print("Rate Clicked") }) {
                Label("Rate Recipe", systemImage: "star.fill")
            }
            Button(action: { print("Review Clicked") }) {
                Label("Review", systemImage: "pencil")
            }
            Button(action: { print("Unsave Clicked") }) {
                Label("Unsave", systemImage: "bookmark.slash")
            }
            Button(action: {
                viewModel.logout{ success in
                    navigateToLogin = false
                    if success {
                        print("Logout successful!")
                        navigateToLogin = true
                    } else {
                        print("Logout failed.")
                    }
                }
            }) {
                Label("Logout", systemImage: "arrow.backward.square")
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 25))
                .foregroundColor(Color.black)
                .padding()
        }.padding(.horizontal,5)
    }
}

struct ProfileStats: View {
    var body: some View {
        HStack(spacing: 40) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundColor(Color.gray)
            
            HStack {
                ProfileStatItem(label: "Recipe", value: "4")
                ProfileStatItem(label: "Followers", value: "2.5 M")
                ProfileStatItem(label: "Following", value: "270")
            }
        }
//        .padding()
    }
}

struct ProfileStatItem: View {
    var label: String
    var value: String

    var body: some View {
        VStack {
            Text(label)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.bottom, 2)
            Text(value)
                .fontWeight(.bold)
        }
    }
}

struct ProfileDetails: View {
    var user: User

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5){
                Text(user.displayName ?? "User")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.horizontal, 25)
                
                Text("Chef")
                    .font(.footnote)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .padding(.horizontal, 25)
                
                Text("Private Chef")
                    .font(.callout)
                    .padding(.horizontal, 25)
                
                Text("Passionate about food and life.🍕🍔🍣🍎")
                    .font(.callout)
                    .foregroundColor(Color.gray.opacity(0.8))
                    .padding(.horizontal, 25)
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct SubButtons: View {
    @State private var selectedButton: String = "Recipe" // Default selected button

    var body: some View {
        HStack(spacing: 10) {
            ActionButton(title: "Recipe", selectedButton: $selectedButton)
            ActionButton(title: "Videos", selectedButton: $selectedButton)
            ActionButton(title: "Tag", selectedButton: $selectedButton)
        }
        .padding()
    }
}

struct ActionButton: View {
    var title: String
    @Binding var selectedButton: String

    var isSelected: Bool {
        selectedButton == title
    }

    var body: some View {
        Button(action: {
            selectedButton = title
        }) {
            Text(title)
                .frame(width: 100, height: 40)
                .background(isSelected ? Color.green : Color.white.opacity(0.1))
                .foregroundColor(isSelected ? Color.white : Color.green)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.1)) 
                )
                .cornerRadius(8)
        }
    }
}

#Preview {
    ProfileView()
}
