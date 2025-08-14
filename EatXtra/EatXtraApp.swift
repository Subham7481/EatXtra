//
//  EatXtraApp.swift
//  EatXtra
//
//  Created by Subham Patel on 13/01/25.
//

import SwiftUI
import Firebase

@main
struct EatXtraApp: App {
    @StateObject var viewModel = LoginViewViewModel()
    @StateObject var vm = ProfileViewViewModel()
    @StateObject var savedManager = SavedRecipeViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if viewModel.isLoggedIn {
                HomeView(viewModel: vm)
                    .environmentObject(viewModel)
                    .environmentObject(savedManager)
            } else {
                SplashView()
            }
        }
    }
}
