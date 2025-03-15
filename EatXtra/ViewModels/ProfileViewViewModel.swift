//
//  ProfileViewViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 21/01/25.
//

import Foundation
import FirebaseAuth

class ProfileViewViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoggedIn: Bool = false

    init() {
        fetchUserData()
    }

//    func fetchUserData() {
//        if let currentUser = Auth.auth().currentUser {
//            user = currentUser
//        }
//    }
    func fetchUserData() {
        if let currentUser = Auth.auth().currentUser {
            self.user = User(uid: currentUser.uid,
                             displayName: currentUser.displayName,
                             email: currentUser.email)
        }
    }


    func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true) // Notify success
        } catch let error {
            print("Failed to log out: \(error.localizedDescription)")
            completion(false) // Notify failure
        }
    }
    func checkAuthentication() {
           // Update isLoggedIn based on current auth state
           isLoggedIn = Auth.auth().currentUser != nil
    }
}
