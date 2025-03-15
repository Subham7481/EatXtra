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
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
