//
//  loginViewViewModel.swift
//  EatXtra
//
//  Created by Subham Patel on 21/01/25.
//
import FirebaseAuth
import Combine
import SwiftUI
class LoginViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    
    init(){
        DispatchQueue.main.async {
               self.isLoggedIn = Auth.auth().currentUser != nil
        }
    }
    
    func signIn(completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                self?.isLoggedIn = false
                completion(false)
            } else {
                self?.isLoggedIn = true
                completion(true)
            }
        }
    }
    
    func checkAuthentication() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}
